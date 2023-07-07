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

        // Do any additional setup after loading the view.
    }
    
    func setupTabs() {
//        [RegistrationPasswordViewController(), RegistrationPersonalDataViewController(), SelectLanguageViewController()].forEach { self.setViewControllers($0, animated: true)}
    }
    
    func createNavigation(mainTitle: String, title: String, image: UIImage,
                          viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationItem.title = mainTitle
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
