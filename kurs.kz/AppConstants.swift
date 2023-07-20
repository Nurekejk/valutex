//
//  AppConstants.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 18.07.2023.
//

import Foundation

final class AppConstants {
   
    // MARK: - Constants
    private let googleMapsAPIKey = "AIzaSyA5vHwbUueRGKvRvVB26tcBrwXtJMjElQ8"
    
    // MARK: - Getters
    public func getGoogleMapsAPIKey() -> String {
        return googleMapsAPIKey
    }
}
