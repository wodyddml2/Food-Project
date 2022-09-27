//
//  SubMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RealmSwift

final class SubMemoViewController: BaseViewController {
    
    let repository = UserMemoListRepository()
    let documentManager = DocumentManager()
    
    var category: String?
    var categoryKey: ObjectId?
    
    var tasks: Results<UserMemo>? {
        didSet {
            subMemoCollectionView.reloadData()
        }
    }
    
    private lazy var subMemoCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(SubMemoCollectionViewCell.self, forCellWithReuseIdentifier: SubMemoCollectionViewCell.reusableIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let filterButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "slider.horizontal.3"), primaryAction: nil, menu: filterButtonClicked())
        
        navigationItem.rightBarButtonItems = [plusButton, filterButton]
        
        navigationController?.navigationBar.tintColor = .black
        
        subMemoCollectionView.showsVerticalScrollIndicator = false
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteMemoViewController()
        if categoryKey != nil {
            vc.categoryKey = categoryKey
            vc.memoCheck = true
        }
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if categoryKey == nil {
            tasks = repository.fecth()
            navigationItem.title = "메모"
        } else {
            if let categoryKey = categoryKey {
                tasks = repository.fetchCategory(category: categoryKey)
            }
            
            guard let category = category else {
                return
            }
            navigationItem.title = category
        }
    }
    
    
    func filterButtonClicked() -> UIMenu {
        if category == nil {
            let rate = UIAction(title: "별점순", image: UIImage(systemName: "star.fill")) { _ in
                self.tasks = self.repository.fetchSort(sort: "storeRate")
            }
            
            let visit = UIAction(title: "방문순", image: UIImage(systemName: "person.3.fill")) { _ in
                self.tasks = self.repository.fetchSort(sort: "storeVisit")
            }
            
            let recentDate = UIAction(title: "최신순", image: UIImage(systemName: "tray.and.arrow.down.fill")) { _ in
                self.tasks = self.repository.fetchSort(sort: "storeDate")
            }
            
            let menu = UIMenu(title: "원하는 방식으로 정렬해주세요.", options: .displayInline, children: [recentDate, rate, visit])
            
            return menu
        } else {
            guard let categoryKey = self.categoryKey else {
                return UIMenu()
            }

            let rate = UIAction(title: "별점순", image: UIImage(systemName: "star.fill")) { _ in
                self.tasks = self.repository.fetchCategorySort(sort: "storeRate", category: categoryKey)
            }
            
            let visit = UIAction(title: "방문순", image: UIImage(systemName: "person.3.fill")) { _ in
                self.tasks = self.repository.fetchCategorySort(sort: "storeVisit", category: categoryKey)
            }
            
            let recentDate = UIAction(title: "최신순", image: UIImage(systemName: "tray.and.arrow.down.fill")) { _ in
                self.tasks = self.repository.fetchCategorySort(sort: "storeDate", category: categoryKey)
            }
            
            let menu = UIMenu(title: "원하는 방식으로 정렬해주세요.", options: .displayInline, children: [recentDate, rate, visit])
            
            return menu
        }
        
    }
    
    override func configureUI() {
        view.addSubview(subMemoCollectionView)
        subMemoCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    override func setConstraints() {
        subMemoCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SubMemoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubMemoCollectionViewCell.reusableIdentifier, for: indexPath) as? SubMemoCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let tasks = tasks {
            cell.storeNameLabel.text = tasks[indexPath.item].storeName
            cell.storeVisitLabel.text = "\(tasks[indexPath.item].storeVisit)번 방문"
            cell.storeRateLabel.text = "\(tasks[indexPath.item].storeRate)"
            cell.storeLocationLabel.text = tasks[indexPath.item].storeAdress
            
            cell.memoImageView.image = documentManager.loadImageFromDocument(fileName: "\(tasks[indexPath.item].objectId).jpg")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let tasks = tasks else { return }
        
        let vc = WriteMemoViewController()
        vc.task = tasks[indexPath.item]
        
        if categoryKey != nil {
            vc.categoryKey = categoryKey
            vc.memoCheck = true
        }
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 1.3
        
        layout.itemSize = CGSize(width: width / 1.7, height: width / 1.2)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        return layout
    }
}
