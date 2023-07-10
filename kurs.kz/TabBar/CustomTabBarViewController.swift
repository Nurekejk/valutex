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
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Setup Views
    func setupTabs() {
        let home = createNavigation(mainTitle: "Обменники", title: "Главная",
                                    selectedImage: UIImage(named: "home_selected")!,
                                    image: UIImage(named: "home_gray")!,
                                    viewController: RegistrationPasswordViewController())
        let money = createNavigation(mainTitle: "Оффер", title: "Оффер",
                                     selectedImage: UIImage(named: "money_selected")!,
                                    image: UIImage(named: "money_gray")!,
                                     viewController: RegistrationPersonalDataViewController())
        let other = createNavigation(mainTitle: "", title: "Еще",
                                     selectedImage: UIImage(named: "other_selected")!,
                                    image: UIImage(named: "other_gray")!,
                                     viewController: SelectLanguageViewController())
        self.setViewControllers([home,money,other], animated: true)
    }
    
    func createNavigation(mainTitle: String, title: String, selectedImage: UIImage, image: UIImage,
                          viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        
        viewController.navigationItem.title = mainTitle
        
        return navigationController
    }
}