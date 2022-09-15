//
//  MapViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

import CoreLocation
import NMapsMap

class MapViewController: BaseViewController {
    private let mainView = MapView()
    
    private let locationManager = CLLocationManager()
    
    var currentLocation: CLLocationCoordinate2D?
    
    let geocoder = CLGeocoder()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RequestSearchAPIManager.shared.requestStore(query: "중랑구 맛집")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .plain, target: self, action: #selector(filterButtonClicked))
        
        mainView.mapCollectionView.delegate = self
        mainView.mapCollectionView.dataSource = self
        mainView.mapCollectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: MapCollectionViewCell.reusableIdentifier)
        mainView.mapCollectionView.collectionViewLayout = mapCollectionViewLayout()
        mainView.mapCollectionView.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0)
    }
    
    override func configureUI() {
        locationManager.delegate = self
        checkUserDeviceLocationServiceAuthorization()
        
    }
 
    
    @objc func filterButtonClicked() {
        let vc = FilterViewController()
        
        present(vc, animated: true)
    }

  
    func setCamera() {
        guard let coordinate = currentLocation else {
            return
        }
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(from: coordinate))
        cameraUpdate.animation = .easeIn
        mainView.mapView.moveCamera(cameraUpdate)
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(from: coordinate)
        marker.mapView = mainView.mapView
    }
    
//    func localInfo() {
//        let location = CLLocation(latitude: locationManager.location?.coordinate.latitude, longitude: locationManager.location?.coordinate.longitude)
//        let locale = Locale(identifier: "Ko_kr")
//        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { [weak self] placemarks, error in
//            <#code#>
//        }
//    }
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
extension MapViewController {
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            showRequestLocationServiceAlert()
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showRequestLocationServiceAlert() 
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default: print("default")
        }
    }
    
    
    
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            currentLocation = coordinate
        }
        locationManager.stopUpdatingLocation()
        setCamera()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showCautionAlert(title: "사용자의 위치를 가져오지 못했습니다.")
    }
    
    // iOS 14 이후
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
