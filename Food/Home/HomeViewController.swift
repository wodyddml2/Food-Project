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
    
    var tasks: [Results<UserMemo>]?
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func configureUI() {
        bannerCollectionSetup()
        memoListTableViewSetup()
        bannerTimer()
    }
    
    override func navigationSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(wishListButtonClicked))
        navigationController?.navigationBar.tintColor = .darkGray
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
    }
    
    @objc func wishListButtonClicked() {
        transition(WishListViewController(), transitionStyle: .push)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == mainView.bannerCollectionView ? bannerInfo.bannerList.count : 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == mainView.bannerCollectionView {
            guard let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reusableIdentifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            bannerCell.bannerImageView.image = bannerInfo.bannerList[indexPath.item].image
            bannerCell.bannerIntroLable.text = bannerInfo.bannerList[indexPath.item].text
            
            return bannerCell
        } else {
            guard let memoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoListCollectionViewCell.reusableIdentifier, for: indexPath) as? MemoListCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            collectionView.tag == 0
            
            return memoCell
        }
        
    }
    func bannerCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize(width: mainView.bannerCollectionView.frame.size.width, height: mainView.bannerCollectionView.frame.size.height) 이건 왜 안될까...??
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainView.bannerCollectionView {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.height / 5.5)
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
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            self.bannerMove()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return category.categoryInfo.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reusableIdentifier, for: indexPath) as? MemoListTableViewCell else {
            return UITableViewCell()
        }
        cell.memoListCollectionView.delegate = self
        cell.memoListCollectionView.dataSource = self
        cell.memoListCollectionView.register(MemoListCollectionViewCell.self, forCellWithReuseIdentifier: MemoListCollectionViewCell.reusableIdentifier)
        cell.memoListCollectionView.collectionViewLayout = memoListCollectionViewLayout()
        cell.memoListCollectionView.tag = indexPath.section
//        if let tasks = tasks {
//           let s = tasks[indexPath.section]
//        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
    private func memoListCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return layout
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category.categoryInfo[section]
    }
}
