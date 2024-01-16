//
//  SearchAmbientCinemaViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/15/24.
//

import UIKit
import MapKit

class SearchAmbientCinemaViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let dataList = TheaterList.mapAnnotations

    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureNavigationBar()
    }
    
    @objc func filterBarButtonTapped() {
        createActionSheet()
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterBarButtonTapped))
    }
    
    func createActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        CinemaType.allCases.forEach { cinemaType in
            let cinemaButton = UIAlertAction(title: cinemaType.rawValue, style: .default) { [weak self] alertAction in
                guard let weakSelf = self else { return }
                weakSelf.searchLocation(with: alertAction.title!)
            }
            alert.addAction(cinemaButton)
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소")
        }
        
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
    
    func searchLocation(with type: String) {
        mapView.removeAnnotations(mapView.annotations)
        
        dataList.forEach { theater in
            if theater.type == type {
                setRegionAndAnnotaionOnMapView(with: theater)
            } else if type == "전체보기" {
                setRegionAndAnnotaionOnMapView(with: theater)
            }
        }
    }
    
    func setRegionAndAnnotaionOnMapView(with theater: Theater) {
        let coordinate = CLLocationCoordinate2D(
            latitude: theater.latitude,
            longitude: theater.longitude
        )
        
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 20_000,
            longitudinalMeters: 20_000
        )
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = theater.location
        
        mapView.addAnnotation(annotation)
    }

}
