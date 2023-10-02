//
//  CustomTabBarViewController.swift
//  kurs.kz
//
//  Created by MacBook on 08.07.2023.
//

import UIKit
import Pulley

final class MainTabBarViewController: UITabBarController {
    
    // MARK: - Properties
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()

        self.tabBar.barTintColor = AppColor.grayWhite.uiColor
        self.tabBar.tintColor = AppColor.primaryBase.uiColor
        self.tabBar.backgroundColor = .white
    }
    
    // MARK: - Setup Views
    func setupTabs() {
        if let data = defaults.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            let home = createNavigation(mainTitle: "Обменники", title: "Главная",
                                        selectedImage: AppImage.home_selected.uiImage!,
                                        image: AppImage.home_gray.uiImage!,
                                        viewController: MapExchangersViewController(
                                            contentViewController: MapViewController(
                                                service: ExchangerListService()),
                                            drawerViewController: ExchangeListViewController()))
            let offer = createNavigation(mainTitle: "Оффер", title: "Оффер",
                                         selectedImage: AppImage.money_selected.uiImage!,
                                         image: AppImage.money_gray.uiImage!,
                                         viewController: OfferSellBuySegmentedController())
            let other = createNavigation(mainTitle: "", title: "Еще",
                                         selectedImage: AppImage.other_selected.uiImage!,
                                         image: AppImage.other_gray.uiImage!,
                                         viewController: ProfileViewController())
            self.setViewControllers([home,offer,other], animated: true)
        } else {
            let home = createNavigation(mainTitle: "Обменники", title: "Главная",
                                        selectedImage: AppImage.home_selected.uiImage!,
                                        image: AppImage.home_gray.uiImage!,
                                        viewController: MapExchangersViewController())
            let offer = createNavigation(mainTitle: "Оффер", title: "Оффер",
                                         selectedImage: AppImage.money_selected.uiImage!,
                                         image: AppImage.money_gray.uiImage!,
                                         viewController: SignInViewController())
            let other = createNavigation(mainTitle: "", title: "Еще",
                                         selectedImage: AppImage.other_selected.uiImage!,
                                         image: AppImage.other_gray.uiImage!,
                                         viewController: SignInViewController())
            self.setViewControllers([home,offer,other], animated: true)
        }
    }
    
    func createNavigation(mainTitle: String,
                          title: String,
                          selectedImage: UIImage,
                          image: UIImage,
                          viewController: UIViewController) -> UIViewController {
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.navigationBar.isTranslucent = false

        navViewController.tabBarItem.title = title
        navViewController.tabBarItem.image = image
        navViewController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        
        navViewController.navigationItem.title = mainTitle
        
        return navViewController
    }
}
