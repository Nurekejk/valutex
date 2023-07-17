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
    `
    private let medeuMarker = GMSMarker(
       position: CLLocationCoordinate2D(latitude: 43.157713441585436, longitude: 77.05901863169184))
    
     private let shymbulakMarker = GMSMarker(
       position: CLLocationCoordinate2D(latitude: 43.113232516457245, longitude: 77.11098765027998))

     private let auylMarker = GMSMarker(
       position: CLLocationCoordinate2D(latitude: 43.162750364364236, longitude: 77.05992323741296))
    
    private let locationManager = CLLocationManager()
    private var currentZoom : Float = 15.0

    // MARK: - UI
    private lazy var googleMapView: GMSMapView = {
        let map =  GMSMapView(frame: view.bounds,
                              camera: camera)
        map.delegate = self
        return map
    }()
    
    private lazy var camera: GMSCameraPosition = {
        return GMSCameraPosition(latitude: 43.241545,
                                 longitude: 76.926355,
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
    
    private lazy var zoomView = UIView()
    
    private lazy var zoomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0.1
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var exchangersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "my-exchanges-navigation"), for: .normal)
        button.addTarget(self, action: #selector(exchangersButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var myLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "my-location"), for: .normal)
        button.addTarget(self, action: #selector(myLocationButtonDidPressed), for: .touchUpInside)
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
        
        zoomStackView.layer.cornerRadius = 12.0
        zoomStackView.layer.masksToBounds = true
        zoomStackView.clipsToBounds = true
        
        zoomView.layer.shadowColor = UIColor.black.cgColor
        zoomView.layer.shadowOpacity = 0.13
        zoomView.layer.shadowOffset = .zero
        zoomView.layer.shadowRadius = 12.0
        zoomView.layer.shadowPath = UIBezierPath(rect: zoomView.bounds).cgPath
        zoomView.layer.shouldRasterize = true
        zoomView.layer.rasterizationScale = UIScreen.main.scale
        
        exchangersButton.layer.shadowColor = UIColor.black.cgColor
        exchangersButton.layer.shadowOpacity = 0.16
        exchangersButton.layer.shadowOffset = .zero
        exchangersButton.layer.shadowRadius = 1000.0
        exchangersButton.layer.shadowPath = UIBezierPath(rect: exchangersButton.bounds).cgPath
        exchangersButton.layer.shouldRasterize = true
        exchangersButton.layer.rasterizationScale = UIScreen.main.scale
        
        myLocationButton.layer.shadowColor = UIColor.black.cgColor
        myLocationButton.layer.shadowOpacity = 0.16
        myLocationButton.layer.shadowOffset = .zero
        myLocationButton.layer.shadowRadius = 1000.0
        myLocationButton.layer.shadowPath = UIBezierPath(rect: myLocationButton.bounds).cgPath
        myLocationButton.layer.shouldRasterize = true
        myLocationButton.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController!.navigationBar.frame = CGRect(x: 0,
                                                                y: 0,
                                                                width: bounds.width,
                                                                height: bounds.height + 100)
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
        label.tintColor = UIColor(named: "navigation_title_color")
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(googleMapView)
        view.backgroundColor = .white
        view.tintColor = .black
        
        locationManager.delegate = self
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestLocation()
                self.googleMapView.isMyLocationEnabled = true
                self.googleMapView.settings.myLocationButton = false
            } else {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
        
        [zoomInButton, zoomOutButton].forEach {
            zoomStackView.addArrangedSubview($0)
        }
        zoomView.addSubview(zoomStackView)
        [exchangersButton, zoomView, myLocationButton].forEach {
            googleMapView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        googleMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        exchangersButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-120)
        }
        
        zoomView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        zoomStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.top.equalTo(zoomView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: - Actions
    @objc private func exchangersButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func zoomInButtonDidPressed() {
        self.currentZoom += 0.5
        zoomInZoomOutGoogleMap()
    }
    
    @objc private func zoomOutButtonDidPressed() {
        self.currentZoom -= 0.5
        zoomInZoomOutGoogleMap()
    }
    
    @objc private func zoomInZoomOutGoogleMap() {
        googleMapView.animate(toZoom: currentZoom)
    }
    
    @objc private func myLocationButtonDidPressed() {
        self.locationManager.startUpdatingLocation()
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
        self.googleMapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
    let infoWindow = CustomInfoWindow()
      infoWindow.configureView(exchangerName: marker.title ?? "", exchangerSnippet: marker.snippet ?? "")
      return infoWindow
  }
}
