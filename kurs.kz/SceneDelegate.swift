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

        if isAuthorized() {
            window?.rootViewController =
            UINavigationController(rootViewController: MainPageViewController())
        } else {
            window?.rootViewController =
            UINavigationController(rootViewController: MainPageViewController())
        }
        window?.makeKeyAndVisible()
    }
    // MARK: - Action

    private func isAuthorized() -> Bool {
        let defaults = UserDefaults.standard
        var isAuthorized = false

        guard let data = defaults.data(forKey: SignInViewController.defaultsTokensKey) else {
            isAuthorized = false
            return isAuthorized
        }

        do {
            let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
            if let accessToken = tokens.access_token,
               let refreshToken = tokens.refresh_token {
                print(accessToken, refreshToken)
                isAuthorized = true
            } else {
                isAuthorized = false
                print("one of the tokens returned nil")
            }
        } catch {
            isAuthorized = false
            print("error while decoding")
        }
        return isAuthorized
    }
}
