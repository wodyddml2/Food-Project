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
    
    let documentManager = DocumentManager()
    
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
        tasks.removeAll()
        for i in 0...category.categoryInfo.count - 1 {
            if !repository.fetchCategorySort(sort: "storeRate", category: i).isEmpty {
                
                tasks.append(repository.fetchCategorySort(sort: "storeRate", category: i))
            }
        }
        allTask = repository.fecth()
        for family in UIFont.familyNames {
            print("-------\(family)------")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
    }
    
    override func configureUI() {
        bannerCollectionSetup()
        memoListTableViewSetup()
        bannerTimer()
    }
    
    override func navigationSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(wishListButtonClicked))
        
        navigationController?.navigationBar.tintColor = .black
        
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
        // index 오류 명확한 해결법이 아닌듯
        if collectionView == mainView.bannerCollectionView {
            return bannerInfo.bannerList.count
        } else {
            print("Collection: \(collectionView.tag)") // section은 0인데 이건 1
            if tasks.isEmpty {
                return 1
            } else {
                if tasks.count == 1{
                    return tasks[0].count
                } else {
                    return tasks[collectionView.tag].count
                }
            }
//            return tasks.isEmpty ? 1 : tasks[collectionView.tag].count
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
                memoCell.memoLabel.text = "메모를 입력해주세요!!"
                memoCell.memoImageView.image = UIImage(named: "dishes")
            } else {
                if tasks.count == 1{
                    memoCell.memoLabel.text = tasks[0][indexPath.item].storeName
                    memoCell.memoImageView.image = documentManager.loadImageFromDocument(fileName: "\(tasks[0][indexPath.item].objectId).jpg")
                } else {
                    memoCell.memoLabel.text = tasks[collectionView.tag][indexPath.item].storeName
                    memoCell.memoImageView.image = documentManager.loadImageFromDocument(fileName: "\(tasks[collectionView.tag][indexPath.item].objectId).jpg")
                }
//                memoCell.memoLabel.text = tasks[collectionView.tag][indexPath.item].storeName
//                memoCell.memoImageView.image = documentManager.loadImageFromDocument(fileName: "\(tasks[collectionView.tag][indexPath.item].objectId).jpg")
            }
            
            
            return memoCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != mainView.bannerCollectionView && !tasks.isEmpty {
            let vc = FixMemoViewController()
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
            return tasks.isEmpty ? CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 5.5) : CGSize(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.height / 5.5)
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
            cell.memoListMoreButton.isHidden = true
            cell.memoListMoreImageView.isHidden = true
            cell.memoListMoreLabel.isHidden = true
        } else {
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
        vc.category = category.categoryInfo[tasks[sender.tag][0].storeCategory]
        vc.categoryKey = tasks[sender.tag][0].storeCategory
        transition(vc, transitionStyle: .push)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tasks.isEmpty ? UIScreen.main.bounds.height / 5 : UIScreen.main.bounds.height / 4
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoListTableHeaderView.reusableIdentifier) as! MemoListTableHeaderView
        header.contentView.backgroundColor = .white
        header.categoryLabel.text = tasks.isEmpty ? nil : category.categoryInfo[tasks[section][0].storeCategory]
        return header
    }
  
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print("table: \(section)")
//        return tasks.isEmpty ? nil : category.categoryInfo[tasks[section][0].storeCategory]
//    }
}

