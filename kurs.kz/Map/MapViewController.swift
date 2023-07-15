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
    private var currentZoom : Float = 10.0
    
    // MARK: - UI
    private lazy var googleMapView: GMSMapView = {
        return GMSMapView(frame: view.bounds,
                          camera: camera)
    }()
    
    private lazy var camera: GMSCameraPosition = {
        return GMSCameraPosition(latitude: -33.86,
                                 longitude: 151.20,
                                 zoom: currentZoom)
    }()
    
    private lazy var zoomInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "zoom-in"), for: .normal)
        button.addTarget(self, action: #selector(zoomInButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var zoomOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "zoom-out"), for: .normal)
        button.addTarget(self, action: #selector(zoomOutButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var zoomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
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
        googleMapView.padding = UIEdgeInsets(top: 116, left: 0, bottom: 0, right: 16)
        zoomStackView.layer.cornerRadius = 12
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
        
        [zoomInButton, zoomOutButton].forEach {
            zoomStackView.addArrangedSubview($0)
        }
        [exchangersButton, zoomStackView].forEach {
            googleMapView.addSubview($0)
        }
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
        
        zoomStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-26)
            make.top.equalToSuperview().offset(16)
        }
    }
    
    // MARK: - Actions
    @objc private func exchangersButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func zoomInButtonDidPressed() {
        self.currentZoom += 1
        zoomInZoomOutGoogleMap()
    }
    
    @objc private func zoomOutButtonDidPressed() {
        self.currentZoom -= 1
        zoomInZoomOutGoogleMap()
    }
    
    @objc private func zoomInZoomOutGoogleMap() {
        googleMapView.animate(toZoom: currentZoom)
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
            zoom: currentZoom,
            bearing: 0,
            viewingAngle: 0)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }
}
