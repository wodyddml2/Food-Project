//
//  MapView.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

import NMapsMap

final class MapView: BaseView {
    
    let mapView: NMFMapView = {
        let view = NMFMapView()
        
        return view
    }()
    
    let currentLocationView: UIView = {
        let view = UIView()
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    let currentLocationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "scope")
        view.tintColor = .darkGray
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
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        currentLocationView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        currentLocationImageView.snp.makeConstraints { make in
            make.edges.equalTo(currentLocationView)
        }
        currentLocationButton.snp.makeConstraints { make in
            make.edges.equalTo(currentLocationView)
        }
        
        mapCollectionView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-35)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height / 8.5)
        }
    }
}
