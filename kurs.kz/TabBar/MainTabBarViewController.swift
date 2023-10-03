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
    private let service: TabBarService
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        self.tabBar.barTintColor = AppColor.grayWhite.uiColor
        self.tabBar.tintColor = AppColor.primaryBase.uiColor
        self.tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTabs()
    }
    // MARK: - Initializers
    init(service: TabBarService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupTabs() {
        let offerController: UIViewController
        
        if let checkedController = checkStatus() {
            offerController = checkedController
        } else {
            offerController = OfferSellBuySegmentedController()
        }

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
                                         viewController: offerController)
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
    private func checkStatus() -> UIViewController? {
        var status: UserStatus?
        service.getUserStatus(completion: { [weak self] result in
            switch result {
            case .success(let result):
                print(result)
                status = result
            case .failure(let error):
                print("error 333 posting review")
            }
        })
        
        guard let offerStatus = status?.status else { return nil }
        switch offerStatus {
        case .create:
            print("create")
            return OfferSellBuySegmentedController()
        case .offerCreated:
            print("created")
            guard let offerСreatedData = status?.offerСreatedData?.first else { return nil }
            
            var offer: Offer?
            
            if let type = offerСreatedData.type,
               let exchangeCurrency = offerСreatedData.exchangeCurrency,
               let exchangeAmount = offerСreatedData.exchangeAmount,
               let exchangeRate = offerСreatedData.exchangeRate {
                offer = Offer(type: type,
                              exchangeСurrency: exchangeCurrency,
                              exchangeAmount: exchangeAmount,
                              exchangeRate: exchangeRate)
            }
            
            guard let unwrappedOffer = offer else { return nil }
            
            return OfferViewController(offer: unwrappedOffer,
                                       symbol: "$",
                                       service: OfferService())
        case .offerAccepted:
            print("accepted")
            return ClientOfferDetailsViewController()
        }
    }
}

