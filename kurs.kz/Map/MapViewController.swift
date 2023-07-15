//
//  MapViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 15.07.2023.
//

import UIKit
import CoreLocation
import GoogleMaps

final class MapViewController: UIViewController {
    
    // MARK: - UI
    private lazy var googleMapView: GMSMapView = {
        return GMSMapView(frame: view.bounds,
                                  camera: camera)
    }()
    
    private lazy var camera: GMSCameraPosition = {
            return GMSCameraPosition(latitude: -33.86,
                                     longitude: 151.20,
                                      zoom: 7)
      }()
    
    private let locationService: LocationServiceProtocol =   LocationService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        locationService.startLocationService()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.frame = CGRect(x: 0,
                                                                y: 0,
                                                                width: self.view.frame.width,
                                                                height: 100)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         locationService.stopLocationService()
     }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        let label = UILabel()
        label.text = "Обменники"
        label.textColor = UIColor(named: "navigation_title_color")
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(googleMapView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        googleMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
