//
//  SceneDelegate.swift
//  kurs.kz
//
//  Created by Islam on 27.06.2023.
//

import UIKit
import Foundation
import Pulley

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        
        var isAutorized = false
        
        let defaults = UserDefaults.standard
        isAutorized = defaults.bool(forKey: SignInViewController.defaultsIsAuthorizedKey)

        if isAutorized {
            window?.rootViewController = MainTabBarViewController()
        } else {
            window?.rootViewController =
            UINavigationController(rootViewController: SelectLanguageViewController())
        }
        window?.makeKeyAndVisible()
    }
}
