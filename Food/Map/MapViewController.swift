//
//  MapViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

import NMapsMap

class MapViewController: BaseViewController {
    let mainView = MapView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .plain, target: self, action: #selector(filterButtonClicked))
        
        mainView.mapCollectionView.delegate = self
        mainView.mapCollectionView.dataSource = self
        mainView.mapCollectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: MapCollectionViewCell.reusableIdentifier)
        mainView.mapCollectionView.collectionViewLayout = mapCollectionViewLayout()
        mainView.mapCollectionView.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0)
    }
    
    @objc func filterButtonClicked() {
        let vc = FilterViewController()
        
        present(vc, animated: true)
    }

  
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.reusableIdentifier, for: indexPath) as? MapCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.mapCollectionView.frame.size.width / 1.4, height: mainView.mapCollectionView.frame.size.height / 1.7)
    }
    func mapCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 20
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PopupViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}
