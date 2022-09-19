//
//  SubMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RealmSwift

protocol UserMemoDelegate {
    func reloadUserMemo(updateTasks: Results<UserMemo>)
}

final class SubMemoViewController: BaseViewController {
    
    var category: String?
    var categoryKey: Int?
    
    let repository = UserMemoListRepository()
    
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
        
        tasks = repository.fetchCategory(category: categoryKey ?? 0)
        guard let category = category else {
            return
        }
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let filterButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "slider.horizontal.3"), primaryAction: nil, menu: filterButtonClicked())
        navigationItem.rightBarButtonItems = [plusButton, filterButton]
        navigationItem.title = category
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteMemoViewController()
        vc.categoryKey = categoryKey
        vc.delegate = self
        transition(vc, transitionStyle: .presentNavigation)
    }
    
    func filterButtonClicked() -> UIMenu {
        let rate = UIAction(title: "별점순", image: UIImage(systemName: "star.fill")) { _ in
            self.tasks = self.repository.fetchSort(sort: "storeRate", category: self.categoryKey ?? 0)
        }
        
        let visit = UIAction(title: "방문순", image: UIImage(systemName: "person.3.fill")) { _ in
            self.tasks = self.repository.fetchSort(sort: "storeVisit", category: self.categoryKey ?? 0)
        }
        
        let menu = UIMenu(title: "원하는 방식으로 정렬해주세요.", options: .displayInline, children: [rate, visit])
        
        return menu
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
            cell.storeReviewLabel.text = tasks[indexPath.item].storeReview
            cell.memoImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.item].objectId).jpg")
            
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let tasks = tasks else { return }
       
        let vc = WriteMemoViewController()
        vc.categoryKey = categoryKey
        vc.task = tasks[indexPath.item]
        vc.delegate = self
        transition(vc, transitionStyle: .presentNavigation)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 1.3
        
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        layout.minimumLineSpacing = 40
        
        return layout
    }
}

extension SubMemoViewController: UserMemoDelegate {
    func reloadUserMemo(updateTasks: Results<UserMemo>) {
        tasks = updateTasks
    }
}
