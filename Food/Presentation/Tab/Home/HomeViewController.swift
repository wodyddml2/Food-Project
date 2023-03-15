//
//  HomeViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

import RealmSwift

final class HomeViewController: BaseViewController {
    private let mainView = HomeView()
    
    private let bannerInfo = Banner()
    
    private var nowPage = 0
    
    private let category = CategoryInfo()
    
    private let repository = UserMemoListRepository()
    private let categoryRepository = UserCategoryRepository()
    
    var categoryTask: Results<UserCategory>?
    
    var allTask: Results<UserMemo>? {
        didSet {
            randomBanner = allTask?.shuffled()
            mainView.bannerCollectionView.reloadData()
        }
    }
    
    // optional로 변수를 선언해준 상태에서는 초기화가 되어 있지 않기 때문에 append가 불가
    var tasks = [Results<UserMemo>]() {
        didSet {
            mainView.memoListTableView.reloadData()
        }
    }
    
    private lazy var randomBanner = allTask?.shuffled()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "category") == false {
            categorySet()
        }
        categoryTask = categoryRepository.fetch()
        
        tasks.removeAll()
        
        if let categoryTask = categoryTask {
            for i in categoryTask {
                if !repository.fetchCategorySort(sort: "storeRate", category: i.objectId).isEmpty {
                    
                    tasks.append(repository.fetchCategorySort(sort: "storeRate", category: i.objectId))
                }
            }
        }
        
        allTask = repository.fetch()
        navigationSet()
        
    }
    
    private func categorySet() {
        
        for i in category.categoryInfo {
            let info = UserCategory(category: i)
            do {
                try categoryRepository.addRealm(item: info)
            } catch {
                print("error")
            }
        }
        UserDefaults.standard.set(true, forKey: "category")
    }
    
    override func configureUI() {
        adoptionOfDelegate()
        bannerTimer()
    }
    
    private func navigationSet() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(wishListButtonClicked))
        
        navigationController?.navigationBar.tintColor = .darkPink
        navigationItem.backButtonTitle = ""
        navigationItem.title = "홈"
    }
    
    private func adoptionOfDelegate() {
        mainView.bannerCollectionView.delegate = self
        mainView.bannerCollectionView.dataSource = self
        
        mainView.memoListTableView.delegate = self
        mainView.memoListTableView.dataSource = self
    }
    
    @objc func wishListButtonClicked() {
        transition(WishListViewController(), transitionStyle: .push)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == mainView.bannerCollectionView {
            return bannerInfo.bannerList.count
        } else {
            if tasks.isEmpty {
                return 1
            } else {
                if tasks.count == 1 {
                    return tasks[0].count
                } else {
                    return tasks[collectionView.tag].count
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.bannerCollectionView {
            guard let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reusableIdentifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            bannerCollectionCell(bannerCell, indexPath: indexPath)
            return bannerCell
        } else {
            guard let memoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoListCollectionViewCell.reusableIdentifier, for: indexPath) as? MemoListCollectionViewCell else {
                return UICollectionViewCell()
            }
            memoCollectionCell(memoCell, collectionView: collectionView, indexPath: indexPath)
            return memoCell
        }
    }
    
    private func bannerCollectionCell(_ cell: BannerCollectionViewCell, indexPath: IndexPath) {
        if let randomBanner = randomBanner {
            if randomBanner.count >= 3 {
                
                cell.bannerImageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "\(randomBanner[indexPath.item].objectId).jpg")
                cell.bannerIntroLable.text = randomBanner[indexPath.item].storeName
            } else {
                cell.bannerImageView.image = bannerInfo.bannerList[indexPath.item].image
                cell.bannerIntroLable.text = bannerInfo.bannerList[indexPath.item].text
            }
        } else {
            cell.bannerImageView.image = bannerInfo.bannerList[indexPath.item].image
            cell.bannerIntroLable.text = bannerInfo.bannerList[indexPath.item].text
        }
    }
    
    private func memoCollectionCell(_ cell: MemoListCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        if tasks.isEmpty {
            cell.memoImageView.image = nil
            cell.memoLabel.snp.remakeConstraints { make in
                make.center.equalTo(cell)
            }
            cell.memoLabel.text = "메모를 작성해주세요 :)"
            
        } else {
            cell.memoLabel.snp.remakeConstraints { make in
                make.centerX.equalTo(cell.memoImageView)
                make.leading.lessThanOrEqualTo(cell.memoImageView).offset(4)
                make.trailing.lessThanOrEqualTo(cell.memoImageView).offset(-4)
                make.top.equalTo(cell.memoImageView.snp.bottom).offset(8)
                make.bottom.equalTo(-8)
            }
            if tasks.count == 1 {
                cell.memoLabel.text = tasks[0][indexPath.item].storeName
                cell.memoImageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "\(tasks[0][indexPath.item].objectId).jpg")
            } else {
                cell.memoLabel.text = tasks[collectionView.tag][indexPath.item].storeName
                cell.memoImageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "\(tasks[collectionView.tag][indexPath.item].objectId).jpg")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != mainView.bannerCollectionView && !tasks.isEmpty {
            let vc = FixMemoViewController()
            
            vc.category = categoryRepository.fetchCategory(category: tasks[collectionView.tag][0].storeCategory)[0].category
            
            vc.task = tasks[collectionView.tag][indexPath.item]
            transition(vc, transitionStyle: .present)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainView.bannerCollectionView {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else {
            return tasks.isEmpty ? CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3) : CGSize(width: UIScreen.main.bounds.width / 3.5, height: 140)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == mainView.bannerCollectionView {
            nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
        
    }
    
    private func bannerMove() {
        if nowPage == bannerInfo.bannerList.count - 1 {
            mainView.bannerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
            nowPage = 0
            return
        }
        nowPage += 1
        mainView.bannerCollectionView.scrollToItem(at: IndexPath(item: nowPage, section: 0), at: .right, animated: true)
    }
    
    private func bannerTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.bannerMove()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tasks.isEmpty ? 1 : tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reusableIdentifier, for: indexPath) as? MemoListTableViewCell else {
            return UITableViewCell()
        }
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self

        cell.collectionView.collectionViewLayout = collectionViewLayout()
        
        cell.moreButton.tag = indexPath.section
        cell.moreButton.addTarget(self, action: #selector(moreButtonClicked(sender:)), for: .touchUpInside)
        
        if tasks.isEmpty {
            mainView.memoListTableView.separatorStyle = .none
            cell.itemHidden(color: .background, hidden: true)
        } else {
            mainView.memoListTableView.separatorStyle = .singleLine
            cell.itemHidden(color: .white, hidden: false)
        }
        
        cell.collectionView.tag = indexPath.section
        
        cell.collectionView.reloadData()
        
        return cell
    }
    
    @objc func moreButtonClicked(sender: UIButton) {
        let vc = SubMemoViewController()
        vc.viewModel.category = categoryRepository.fetchCategory(category: tasks[sender.tag][0].storeCategory)[0].category
        vc.viewModel.categoryKey = tasks[sender.tag][0].storeCategory
        
        transition(vc, transitionStyle: .push)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tasks.isEmpty ? UIScreen.main.bounds.height / 3 : 190
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoListTableHeaderView.reusableIdentifier) as? MemoListTableHeaderView else { return nil }
        
        if tasks.isEmpty {
            header.headerConfig()
        } else {
            header.headerConfig(color: .white, text: categoryRepository.fetchCategory(category: tasks[section][0].storeCategory)[0].category)
        }
        
        return header
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        if !tasks.isEmpty {
            layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        }
        
        return layout
    }
}
