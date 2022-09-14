//
//  SubMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

class SubMemoViewController: BaseViewController {
    private lazy var subMemoCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(SubMemoCollectionViewCell.self, forCellWithReuseIdentifier: SubMemoCollectionViewCell.reusableIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubMemoCollectionViewCell.reusableIdentifier, for: indexPath) as? SubMemoCollectionViewCell else {
            return UICollectionViewCell()
        }

        return cell
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
