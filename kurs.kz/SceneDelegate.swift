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
        
        let isAuthorized = checkAuth().0
        
        if isAuthorized {
            window?.rootViewController = MainTabBarViewController()
        } else {
            window?.rootViewController =
                UINavigationController(rootViewController: SelectLanguageViewController())
        }
        window?.makeKeyAndVisible()
    }
    // MARK: - Action
    private func checkAuth() -> (Bool, [String: String]) {
        let defaults = UserDefaults.standard
        var isAuthorized = false
        var headers = [String: String]()
        
        guard let data = defaults.data(forKey: SignInViewController.defaultsTokensKey) else {
            isAuthorized = false
            return (isAuthorized, headers)
        }
        
        do {
            let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
            if let accessToken = tokens.access_token {
                headers["Authorization"] = "Bearer \(accessToken)"
                isAuthorized = true
            } else {
                isAuthorized = false
                fatalError("accessToken returned nil")
            }
        } catch {
            isAuthorized = false
            print("error while decoding")
        }
        return (isAuthorized, headers)
    }
}
