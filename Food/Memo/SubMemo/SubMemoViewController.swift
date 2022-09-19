//
//  SubMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RealmSwift

final class SubMemoViewController: BaseViewController {
    
    var category: String?
    var categoryKey: Int?
    
    let repository = UserMemoListRepository()
    
    var tasks: Results<UserMemo>?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        navigationItem.title = category
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteMemoViewController()
        vc.categoryKey = categoryKey
        transition(vc, transitionStyle: .presentNavigation)
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
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        transition(WriteMemoViewController(), transitionStyle: .presentNavigation)
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
