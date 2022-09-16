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
    
    var markers = [NMFMarker]()
    
    var storeData: [StoreInfo] = []
    
    var currentIndex: CGFloat = 0
    
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
//        mainView.mapCollectionView.isPagingEnabled = true
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
    }
    

}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapCollectionViewCell.reusableIdentifier, for: indexPath) as? MapCollectionViewCell else {return UICollectionViewCell()}
        cell.storeNameLabel.text = storeData[indexPath.item].name
        cell.storeLocationLabel.text = storeData[indexPath.item].adress
        
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

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = mainView.mapCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //320 : 셀사이즈
        let cellWidthIncludingSpacing = mainView.mapCollectionView.frame.size.width / 1.4 + layout.minimumLineSpacing
        // UnsafeMutablePointer<CGPoint>: 특정 유형의 데이터에 엑세스하고 조작하기위한 포인터(메모리 주솟값?)
        // pointee: 포인터가 참조하는 인스턴스에 엑세스
        // contentInset: 스크롤 뷰 모서리에 삽입되는 사용자 지정거리
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
            
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        if currentIndex > roundedIndex {
            currentIndex -= 1
            roundedIndex = currentIndex
        } else if currentIndex < roundedIndex {
            currentIndex += 1
            roundedIndex = currentIndex
        }
        
        offset = CGPoint(x: (roundedIndex * cellWidthIncludingSpacing) - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        markers[Int(currentIndex)].iconTintColor = .red
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
        // 이따 수정
        locationManager.stopUpdatingLocation()
        
        guard let coordinate = currentLocation else {
            return
        }
        
      
        RequestSearchAPIManager.shared.requestRegion(lat: coordinate.latitude, lon: coordinate.longitude) { region in
            
            RequestSearchAPIManager.shared.requestStore(query: "\(region.firstArea) \(region.secondArea) \(region.thirdArea) 맛집") { store in
                self.storeData = store
               
                DispatchQueue.main.async {
                    for stores in store {
                        let marker = NMFMarker()
                        marker.position = NMGLatLng(lat: stores.lon, lng: stores.lat)
                        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                            
                            marker.iconTintColor = UIColor.blue
                            
                            if let firstIndex = store.firstIndex(of: stores) {
                                self.mainView.mapCollectionView.scrollToItem(at: NSIndexPath(item: firstIndex, section: 0) as IndexPath , at: .left, animated: true)
                                self.currentIndex = CGFloat(firstIndex)
                            }
      
                            print("마커 터치")
                            return true
                        }
                        self.markers.append(marker)
                        
                        marker.mapView = self.mainView.mapView
                    }
                    self.mainView.mapCollectionView.reloadData()
                }
            }
        }
        setCamera()
    }
    
//    func markerSetup(completionHandler: @escaping(_ overlay: NMFOverlay) -> Bool) {
//
//        for store in storeData {
//            let marker = NMFMarker()
//            marker.position = NMGLatLng(lat: store.lon, lng: store.lat)
//            marker.touchHandler = completionHandler
//            markers.append(marker)
//        }
//    }
    
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
