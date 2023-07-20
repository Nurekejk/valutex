//
//  AppDelegate.swift
//  kurs.kz
//
//  Created by Islam on 27.06.2023.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // swiftlint:disable all
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        GMSServices.provideAPIKey(AppConstants().getGoogleMapsAPIKey())
        
        return true
    }
    // swiftlint:enable all
}
