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
    
    let locationManager = CLLocationManager()
    
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
    
    private lazy var exchangersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "my-exchanges-navigation"), for: .normal)
        button.addTarget(self, action: #selector(exchangersButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.frame = CGRect(x: 0,
                                                                y: 0,
                                                                width: self.view.frame.width,
                                                                height: 100)
        googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 450, right: 16)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        
        locationManager.delegate = self
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestLocation()
                self.googleMapView.isMyLocationEnabled = true
                self.googleMapView.settings.myLocationButton = true
            } else {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
        
        googleMapView.addSubview(exchangersButton)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        googleMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        exchangersButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-120)
        }
    }
    
    // MARK: - Actions
    @objc private func exchangersButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.requestLocation()
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        googleMapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: 15,
            bearing: 0,
            viewingAngle: 0)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }
}
