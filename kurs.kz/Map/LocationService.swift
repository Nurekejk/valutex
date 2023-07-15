//
//  LocationService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 15.07.2023.
//

import UIKit
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func updateLocation(_ location: CLLocationCoordinate2D?)
    func authorizattionStatusDidChanged(isAccessGranted: Bool)
}

protocol LocationServiceProtocol: CLLocationManagerDelegate {
    func setDelegate(_ delegate: LocationServiceDelegate?)
    func startLocationService()
    func stopLocationService()
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    // MARK: - States
    private var locationManager: CLLocationManager?
    private weak var delegate: LocationServiceDelegate?
    
    // MARK: - Setters
    func setDelegate(_ delegate: LocationServiceDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Initializers
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
    }
}

extension LocationService: CLLocationManagerDelegate {
    // This method will notify our delegate if location did updated
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        delegate?.updateLocation(locations.last?.coordinate)
    }
    // This method will notify our delegate if Authorization status did changed
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            delegate?.authorizattionStatusDidChanged(isAccessGranted: true)
        default:
            delegate?.authorizattionStatusDidChanged(isAccessGranted: false)
        }
    }
    func startLocationService() {
        if locationManager == nil {
           locationManager = CLLocationManager()
        }
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.distanceFilter = CLLocationDistanceMax
    }
    func stopLocationService() {
        locationManager?.stopUpdatingLocation()
        locationManager?.delegate = nil
        locationManager = nil
    }
}
