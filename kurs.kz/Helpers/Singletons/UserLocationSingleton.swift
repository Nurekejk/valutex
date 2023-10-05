//
//  UserLocationSingleton.swift
//  kurs.kz
//
//  Created by MacBook on 05.10.2023.
//

import Foundation
import CoreLocation

class UserLocationSingleton {
    
    // MARK: - Properties
    static let shared = UserLocationSingleton()

    var userLocation: CLLocation?

    private init() { }

    // MARK: - Methods
    func updateUserLocation(_ location: CLLocation) {
        userLocation = location
    }
    func fetchUserLocation() -> CLLocation? {
        userLocation
    }
}
