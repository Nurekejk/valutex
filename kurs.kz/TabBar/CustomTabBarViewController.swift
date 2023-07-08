//
//  CustomTabBarViewController.swift
//  kurs.kz
//
//  Created by MacBook on 08.07.2023.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    private let registrationBlueColor = CGColor(
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .blue
        // Do any additional setup after loading the view.
    }
    
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
        //        navigationController.viewControllers.first?.navigationItem.title = mainTitle
//        navigationController.viewControllers.first?.navigationItem.
//        navigationController.viewControllers.first?.navigationItem.rightBarButtonItem
        return navigationController
    }
}
