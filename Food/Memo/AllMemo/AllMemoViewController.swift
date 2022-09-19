//
//  AllCollectionViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import SnapKit

final class AllMemoViewController: BaseViewController {
    private lazy var allMemoCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(AllMemoCollectionViewCell.self, forCellWithReuseIdentifier: AllMemoCollectionViewCell.reusableIdentifier)
        return view
    }()
    
    let categoryName: [String] = ["한식", "중식", "일식", "양식", "아시안", "디져트", "디져트", "술집"]

    override func viewDidLoad() {
        super.viewDidLoad()

        allMemoCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    override func configureUI() {
        view.addSubview(allMemoCollectionView)
        
        navigationItem.title = "메모"
    }
    
    override func setConstraints() {
        allMemoCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AllMemoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMemoCollectionViewCell.reusableIdentifier, for: indexPath) as? AllMemoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.memoCategoryLabel.text = categoryName[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AllMemoCollectionViewCell else {return}
        
        let vc = SubMemoViewController()
        
        vc.category = cell.memoCategoryLabel.text
        
        vc.categoryKey = indexPath.item
        
        transition(vc, transitionStyle: .push)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 2.5
        let spacing: CGFloat = 16
        
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
}
