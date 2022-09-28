//
//  MapView.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

import NMapsMap

final class MapView: BaseView {
 
    lazy var mapView: NMFMapView = {
        let view = NMFMapView()
       
        return view
    }()
    

    let currentLocationView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.backgroundColor = .white
        return view
    }()
    
    let currentLocationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "scope")
        view.tintColor = .black
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
        
        [mapView, mapCollectionView,currentLocationView, currentLocationImageView, currentLocationButton].forEach {
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
            make.edges.equalTo(currentLocationView).inset(8)
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
