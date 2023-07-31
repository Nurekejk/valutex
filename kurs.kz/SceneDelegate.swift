//
//  SceneDelegate.swift
//  kurs.kz
//
//  Created by Islam on 27.06.2023.
//

import UIKit
import Foundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
      
        let defaults = UserDefaults.standard
        let isAutorized = defaults.bool(forKey: "isAutorized")

        if isAutorized {
            window?.rootViewController =
                UINavigationController(rootViewController: SignInViewController())
        } else {
            window?.rootViewController =
                UINavigationController(rootViewController: SignInViewController())
        }

        window?.makeKeyAndVisible()
    }
}
