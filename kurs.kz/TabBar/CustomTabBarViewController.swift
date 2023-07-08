//
//  CustomTabBarViewController.swift
//  kurs.kz
//
//  Created by MacBook on 08.07.2023.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    let registrationPasswordViewController = RegistrationPasswordViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        // Do any additional setup after loading the view.
    }
    
    func setupTabs() {
        let home = createNavigation(mainTitle: "Home", title: "Hoooooome",
                                    image: UIImage(named: "home_selected")!,
                                    viewController: RegistrationPasswordViewController())
        let money = createNavigation(mainTitle: "Money", title: "OOOOO",
                                    image: UIImage(named: "money_gray")!,
                                     viewController: RegistrationPersonalDataViewController())
        let other = createNavigation(mainTitle: "Other", title: "MOOON",
                                    image: UIImage(named: "other_gray")!,
                                     viewController: SelectLanguageViewController())
        self.setViewControllers([home,money,other], animated: true)
//        [home, money, other].forEach
//        { self.setViewControllers($0, animated: true)}
    }
    
    func createNavigation(mainTitle: String, title: String, image: UIImage,
                          viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationItem.title = mainTitle
        
// navigationController.viewControllers.first?.title = mainTitle + " Controller"
        navigationController.viewControllers.first?.navigationItem.rightBarButtonItem =
        UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
        navigationController.viewControllers.first?.navigationItem.rightBarButtonItem?.tintColor =
            .green
        return navigationController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
