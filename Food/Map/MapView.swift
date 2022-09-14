//
//  MapView.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

import NMapsMap

class MapView: BaseView {
    
    let mapView: NMFMapView = {
       let view = NMFMapView()
        
        return view
    }()
    
    let currentLocationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let currentLocationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "scope")
        return view
    }()
    
    let currentLocationButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    
    let mapCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        
        [mapView, mapCollectionView, currentLocationView, currentLocationImageView, currentLocationButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(self.safeAreaLayoutGuide)
        }
        currentLocationView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        currentLocationImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(currentLocationView)
        }
        currentLocationButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(currentLocationView)
        }
        
        mapCollectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
    }
}
