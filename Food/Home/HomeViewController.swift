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
    
    let category = CategoryInfo()
    
    let repository = UserMemoListRepository()
    let categoryRepository = UserCategoryRepository()
    let documentManager = DocumentManager()
    
    let userCategory = UserCategory()
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
    
    lazy var randomBanner = allTask?.shuffled()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "category") == false {
            categorySet()
        }
        categoryTask = categoryRepository.fecth()
        
        tasks.removeAll()
        
        if let categoryTask = categoryTask {
            for i in categoryTask {
                if !repository.fetchCategorySort(sort: "storeRate", category: i.objectId).isEmpty {
                    
                    tasks.append(repository.fetchCategorySort(sort: "storeRate", category: i.objectId))
                }
            }
        }
        
        allTask = repository.fecth()
        navigationSet()
        
    }
    
    func categorySet() {
        
        for i in category.categoryInfo {
            let info = UserCategory(category: i)
            categoryRepository.addRealm(item: info)
        }
        
        UserDefaults.standard.set(true, forKey: "category")
    }
    
    override func configureUI() {
        bannerCollectionSetup()
        memoListTableViewSetup()
        bannerTimer()
        
    }
    
    func navigationSet() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(wishListButtonClicked))
        
        navigationController?.navigationBar.tintColor = UIColor(named: SetColor.darkPink.rawValue)
        navigationItem.backButtonTitle = ""
        navigationItem.title = "홈"
    }
    
    private func bannerCollectionSetup() {
        mainView.bannerCollectionView.delegate = self
        mainView.bannerCollectionView.dataSource = self
        mainView.bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reusableIdentifier)
        mainView.bannerCollectionView.isPagingEnabled = true
        mainView.bannerCollectionView.showsHorizontalScrollIndicator = false
        
        mainView.bannerCollectionView.collectionViewLayout = bannerCollectionViewLayout()
    }
    
    private func memoListTableViewSetup() {
        mainView.memoListTableView.delegate = self
        mainView.memoListTableView.dataSource = self
        mainView.memoListTableView.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.reusableIdentifier)
        mainView.memoListTableView.register(MemoListTableHeaderView.self, forHeaderFooterViewReuseIdentifier: MemoListTableHeaderView.reusableIdentifier)
        mainView.memoListTableView.showsVerticalScrollIndicator = false
        mainView.memoListTableView.bounces = false
        mainView.memoListTableView.backgroundColor = UIColor(named: SetColor.background.rawValue)
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
            
            if let randomBanner = randomBanner {
                if randomBanner.count >= 3 {
                    
                    bannerCell.bannerImageView.image = documentManager.loadImageFromDocument(fileName: "\(randomBanner[indexPath.item].objectId).jpg")
                    bannerCell.bannerIntroLable.text = randomBanner[indexPath.item].storeName
                } else {
                    bannerCell.bannerImageView.image = bannerInfo.bannerList[indexPath.item].image
                    bannerCell.bannerIntroLable.text = bannerInfo.bannerList[indexPath.item].text
                }
            } else {
                bannerCell.bannerImageView.image = bannerInfo.bannerList[indexPath.item].image
                bannerCell.bannerIntroLable.text = bannerInfo.bannerList[indexPath.item].text
            }
            
            return bannerCell
        } else {
            guard let memoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoListCollectionViewCell.reusableIdentifier, for: indexPath) as? MemoListCollectionViewCell else {
                return UICollectionViewCell()
            }
            if tasks.isEmpty {
                memoCell.memoImageView.image = nil
                memoCell.memoLabel.snp.remakeConstraints { make in
                    make.center.equalTo(memoCell)
                }
                memoCell.memoLabel.text = "메모를 작성해주세요 :)"
                
            } else {
                memoCell.memoLabel.snp.remakeConstraints { make in
                    make.centerX.equalTo(memoCell.memoImageView)
                    make.leading.lessThanOrEqualTo(memoCell.memoImageView).offset(4)
                    make.trailing.lessThanOrEqualTo(memoCell.memoImageView).offset(-4)
                    make.top.equalTo(memoCell.memoImageView.snp.bottom).offset(8)
                    make.bottom.equalTo(-8)
                }
                if tasks.count == 1{
                    memoCell.memoLabel.text = tasks[0][indexPath.item].storeName
                    memoCell.memoImageView.image = documentManager.loadImageFromDocument(fileName: "\(tasks[0][indexPath.item].objectId).jpg")
                } else {
                    memoCell.memoLabel.text = tasks[collectionView.tag][indexPath.item].storeName
                    memoCell.memoImageView.image = documentManager.loadImageFromDocument(fileName: "\(tasks[collectionView.tag][indexPath.item].objectId).jpg")
                }
            }
            
            return memoCell
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
    func bannerCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
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
        if tasks.isEmpty {
            return 1
        } else {
            return tasks.count
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reusableIdentifier, for: indexPath) as? MemoListTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.memoListCollectionView.delegate = self
        cell.memoListCollectionView.dataSource = self
        cell.memoListCollectionView.register(MemoListCollectionViewCell.self, forCellWithReuseIdentifier: MemoListCollectionViewCell.reusableIdentifier)
        cell.memoListCollectionView.collectionViewLayout = memoListCollectionViewLayout()
        
        cell.memoListMoreButton.tag = indexPath.section
        cell.memoListMoreButton.addTarget(self, action: #selector(memoListMoreButtonClicked(sender:)), for: .touchUpInside)
        
        if tasks.isEmpty {
            mainView.memoListTableView.separatorStyle = .none
            cell.backgroundColor = UIColor(named: SetColor.background.rawValue)
            cell.memoListMoreButton.isHidden = true
            cell.memoListMoreImageView.isHidden = true
            cell.memoListMoreLabel.isHidden = true
        } else {
            mainView.memoListTableView.separatorStyle = .singleLine
            cell.backgroundColor = .white
            cell.memoListMoreButton.isHidden = false
            cell.memoListMoreImageView.isHidden = false
            cell.memoListMoreLabel.isHidden = false
        }
        
        cell.memoListCollectionView.tag = indexPath.section
        
        cell.memoListCollectionView.reloadData()
        
        return cell
    }
    
    
    @objc func memoListMoreButtonClicked(sender: UIButton) {
        let vc = SubMemoViewController()
        vc.category = categoryRepository.fetchCategory(category: tasks[sender.tag][0].storeCategory)[0].category
        vc.categoryKey = tasks[sender.tag][0].storeCategory
        
        transition(vc, transitionStyle: .push)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tasks.isEmpty ? UIScreen.main.bounds.height / 3 : 190
    }
    
    private func memoListCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        if !tasks.isEmpty {
            layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        }
        
        return layout
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoListTableHeaderView.reusableIdentifier) as? MemoListTableHeaderView else {
            return nil
        }
        
        if tasks.isEmpty {
            header.categoryLabel.text = nil
            header.contentView.backgroundColor = UIColor(named: SetColor.background.rawValue)
        } else {
            header.categoryLabel.text =
            categoryRepository.fetchCategory(category: tasks[section][0].storeCategory)[0].category
            header.contentView.backgroundColor = .white
        }
        
        return header
    }
    
}

