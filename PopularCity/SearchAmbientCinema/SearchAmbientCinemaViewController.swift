//
//  SearchAmbientCinemaViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/15/24.
//

import UIKit
import MapKit
import CoreLocation

class SearchAmbientCinemaViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let dataList = TheaterList.mapAnnotations

    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureNavigationBar()
        searchCinemaLocation(with: CinemaType.showAll.rawValue)
        configureCoreLocation()
        checkDeviceLocationAuthorization()
    }
    
    @objc func filterBarButtonTapped() {
        createActionSheet()
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterBarButtonTapped))
    }
    
    func configureCoreLocation() {
        locationManager.delegate = self
    }
}

extension SearchAmbientCinemaViewController {
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("denied")
            let coordinate = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
            setRegionAndAnnotaionOnMapView(with: coordinate, annotationTitle: "청년사관학교 영등포 캠퍼스")
            setLocationSettingAlert()
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Error")
        }
    }
    
    func setLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSettingButton = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingUrl)
            } else {
                print("설정으로 이동하여 주세요")// 아마 토스토 이용해서 알림 ??
            }
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
    
        alert.addAction(goSettingButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}

extension SearchAmbientCinemaViewController {
    func searchCinemaLocation(with type: String) {
        mapView.removeAnnotations(mapView.annotations.filter({ annotation in
            return annotation.title != "내 위치"
        }))
        
        dataList.forEach { theater in
            let coordinate = CLLocationCoordinate2D(
                latitude: theater.latitude,
                longitude: theater.longitude
            )
            if theater.type == type {
                setRegionAndAnnotaionOnMapView(with: coordinate, annotationTitle: theater.location)
            } else if type == "전체보기" {
                setRegionAndAnnotaionOnMapView(with: coordinate, annotationTitle: theater.location)
            }
        }
    }
    
    func setRegionAndAnnotaionOnMapView(with coordinate: CLLocationCoordinate2D, annotationTitle: String) {

        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 20_000,
            longitudinalMeters: 20_000
        )
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = annotationTitle
        
        mapView.addAnnotation(annotation)
    }
    
    func createActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        CinemaType.allCases.forEach { cinemaType in
            let cinemaButton = UIAlertAction(title: cinemaType.rawValue, style: .default) { [weak self] alertAction in
                guard let weakSelf = self else { return }
                weakSelf.searchCinemaLocation(with: alertAction.title!)
            }
            alert.addAction(cinemaButton)
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
}

extension SearchAmbientCinemaViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            print(coordinate.latitude)
            print(coordinate.longitude)
            setRegionAndAnnotaionOnMapView(with: coordinate, annotationTitle: "내 위치")
        }
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // iOS 14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }
}



