//
//  MapViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 15.07.2023.
//

import UIKit
import CoreLocation
import GoogleMaps
import Pulley
import SnapKit
import ProgressHUD

final class MapViewController: UIViewController {
    
    private let service: ExchangerListService
    private var markers = [GMSMarker]()
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
        button.setImage(AppImage.zoom_in.uiImage, for: .normal)
        button.addTarget(self, action: #selector(zoomInButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var zoomOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.zoom_out.uiImage, for: .normal)
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
        button.setImage(AppImage.my_exchanges_navigation.uiImage, for: .normal)
        button.addTarget(self, action: #selector(exchangersButtonDidPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var myLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.my_location.uiImage, for: .normal)
        button.addTarget(self, action: #selector(myLocationButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    init(service: ExchangerListService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        fetchLocation()
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = .white
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(googleMapView)
        view.backgroundColor = .white
        
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
            let distance = (self.pulleyViewController?.drawerDistanceFromBottom.distance ?? 0) * (-1)
            make.bottom.equalToSuperview().offset(distance - 16)
        }
        
        zoomView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
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
    
    // MARK: - Callback
    private func fetchLocation() {
        service.fetchExchangers(currencyCode: "USD", cityId: 1) { exchangers in
            exchangers.forEach { [weak self] exchanger in
                let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(exchanger.latitude),
                                          longitude: CLLocationDegrees(exchanger.longitude))
                let marker = GMSMarker(position: position)
                marker.title = exchanger.mainTitle
                marker.snippet = exchanger.address
                marker.map = self?.googleMapView
                self?.markers.append(marker)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func exchangersButtonDidPressed() {
        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
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
    
    @objc func keyboardWillAppear() {
        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.requestLocation()
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.myLocationButton = false
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

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = CustomInfoWindow()
        infoWindow.configureView(exchangerName: marker.title ?? "", exchangerSnippet: marker.snippet ?? "")
        return infoWindow
    }
}

// MARK: - PulleyPrimaryContentControllerDelegate
extension MapViewController: PulleyPrimaryContentControllerDelegate {
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController,
                                         distance: CGFloat, bottomSafeArea: CGFloat) {
        exchangersButton.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().inset(distance + 16)
        }
    }
}
