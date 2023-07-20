//
//  CustomTabBarViewController.swift
//  kurs.kz
//
//  Created by MacBook on 08.07.2023.
//

import UIKit

final class CustomTabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()

        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .blue
    }
    
    // MARK: - Setup Views
    func setupTabs() {
        let home = createNavigation(mainTitle: "Обменники", title: "Главная",
                                    selectedImage: AppImage.home_selected.uiImage!,
                                    image: AppImage.home_gray.uiImage!,
                                    viewController: EmptyViewController())
        let money = createNavigation(mainTitle: "Оффер", title: "Оффер",
                                     selectedImage: AppImage.money_selected.uiImage!,
                                     image: AppImage.money_gray.uiImage!,
                                     viewController: EmptyViewController())
        let other = createNavigation(mainTitle: "", title: "Еще",
                                     selectedImage: AppImage.other_selected.uiImage!,
                                     image: AppImage.other_gray.uiImage!,
                                     viewController: ProfileViewController())
        self.setViewControllers([home,money,other], animated: true)
    }
    
    func createNavigation(mainTitle: String,
                          title: String,
                          selectedImage: UIImage,
                          image: UIImage,
                          viewController: UIViewController) -> UIViewController {
        let viewController = viewController
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        
        viewController.navigationItem.title = mainTitle
        
        return viewController
    }
}
