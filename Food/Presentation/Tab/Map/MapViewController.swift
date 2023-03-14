//
//  MapViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit
import CoreLocation

import NMapsMap

final class MapViewController: BaseViewController {
    
    private let mainView = MapView()
    
    private let locationManager = CLLocationManager()
    
    private var markers = [NMFMarker]()
    
    private var regionData: RegionVO?
    private var storeData: [StoreVO] = []
    
    private var currentIndex: CGFloat = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        locationManager.delegate = self
        
        mapCollectionViewSetup()
        checkUserDeviceLocationServiceAuthorization()
        
        mainView.currentLocationButton.addTarget(self, action: #selector(currentLocationButtonClicked) , for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkNotificationObserver), name: Notification.Name("network"), object: nil)
        
    }
    
    @objc private func networkNotificationObserver() {
        mainView.mapView.authorize()
    }
    override func navigationSetup() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "맛집 지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
    }
    
    private func mapCollectionViewSetup() {
        mainView.mapCollectionView.delegate = self
        mainView.mapCollectionView.dataSource = self
    }
    
    @objc private func searchButtonClicked() {
        transition(SearchViewController(), transitionStyle: .presentNavigation)
    }
    
    @objc private func currentLocationButtonClicked() {
        if locationManager.authorizationStatus != .denied && NetworkMonitor.shared.isConnected {
            currentIndex = 0
            mainView.mapCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            
            markers.forEach {
                $0.mapView = nil
            }
            markers.removeAll()
            
            checkUserDeviceLocationServiceAuthorization()
        } else if !NetworkMonitor.shared.isConnected {
            present(NetworkMonitor.shared.showNetworkAlert(), animated: true)
        } else if locationManager.authorizationStatus == .denied {
            showRequestServiceAlert(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.")
        }
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
        return CGSize(width: mainView.mapCollectionView.frame.size.width / 1.4, height: mainView.mapCollectionView.frame.size.height / 1.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PopupViewController()
        vc.regionData = regionData
        vc.storeData = storeData[indexPath.item]
        transition(vc, transitionStyle: .presentOverFull)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = mainView.mapCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
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
        
        markers.forEach {
            $0.iconImage = NMF_MARKER_IMAGE_RED
        }
        
        markers[Int(currentIndex)].iconImage = NMF_MARKER_IMAGE_YELLOW
        
        updateCamera(latLang: markers[Int(currentIndex)].position)
    }
}

extension MapViewController {
    
    private func requestLocation(lat: Double, lon: Double) {
        RequestSearchAPIManager.shared.requestAPI(type: RegionInfo.self, router: Router.region(lon: lon, lat: lat)) { region in
            switch region {
            case .success(let success):
                let result = success.results.first?.region.toDomain() ?? RegionVO(firstArea: "", secondArea: "", thirdArea: "")
                
                self.regionData = result
                self.requestStore(region: result)
            case .failure(_):
                self.showCautionAlert(title: "정보를 불러지 못했습니다.")
            }
        }
        updateCamera(latLang: NMGLatLng(lat: lat, lng: lon))
    }
    
    private func requestStore(region: RegionVO) {
        RequestSearchAPIManager.shared.requestAPI(type: StoreInfo.self, router: Router.store(query: "\(region.firstArea) \(region.secondArea) \(region.thirdArea) 맛집", page: 1)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.storeData = success.documents.map({ $0.toDomain() })
                
                DispatchQueue.main.async {
                    for store in success.documents {
                        let marker = NMFMarker()
                        marker.position = NMGLatLng(lat: store.toDomain().lon, lng: store.toDomain().lat)
                        marker.iconImage = NMF_MARKER_IMAGE_RED
                        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                            
                            if let firstIndex = success.documents.firstIndex(of: store) {
                                self.mainView.mapCollectionView.scrollToItem(at: NSIndexPath(item: firstIndex, section: 0) as IndexPath , at: .left, animated: true)
                                self.currentIndex = CGFloat(firstIndex)
                                self.markers.forEach {
                                    $0.iconImage = NMF_MARKER_IMAGE_RED
                                }
                                marker.iconImage = NMF_MARKER_IMAGE_YELLOW
                            }
                            self.updateCamera(latLang: marker.position)
                            
                            return true
                        }
                        self.markers.append(marker)
                        
                        marker.mapView = self.mainView.mapView
                    }
                    self.markers[Int(self.currentIndex)].iconImage = NMF_MARKER_IMAGE_YELLOW
                    //
                    self.mainView.mapView.positionMode = .direction
                    self.mainView.mapCollectionView.reloadData()
                }
            case .failure( _ ):
                self.showCautionAlert(title: "정보를 불러지 못했습니다.")
            }
        }
    }
    
    private func updateCamera(latLang: NMGLatLng) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: latLang)
        cameraUpdate.animation = .easeIn
        mainView.mapView.moveCamera(cameraUpdate)
    }
    
    private func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        authorizationStatus = locationManager.authorizationStatus
        
        checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    private func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            
            requestLocation(lat: 37.571323, lon: 126.977511)
            
            showRequestServiceAlert(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.")
            
        case .authorizedWhenInUse:
            locationManager.distanceFilter = 100000
            locationManager.startUpdatingLocation()
            
        default: print("default")
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate = locations.last?.coordinate  else { return }
        
        locationManager.stopUpdatingLocation()
        
        requestLocation(lat: coordinate.latitude, lon: coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showCautionAlert(title: "사용자의 위치를 가져오지 못했습니다.")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
