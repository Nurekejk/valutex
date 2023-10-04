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
    private var offerController: UIViewController?
    private var userStatus: UserStatus? {
        didSet {
            offerController = getController(with: userStatus)
            setupTabs()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkStatus()
        setupTabs()
        self.tabBar.barTintColor = AppColor.grayWhite.uiColor
        self.tabBar.tintColor = AppColor.primaryBase.uiColor
        self.tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkStatus()
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
        if offerController == nil {
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
                                         viewController: offerController!)
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
    
    private func checkStatus() {
        service.getUserStatus(completion: { [weak self] result in
            switch result {
            case .success(let result):
                self?.userStatus = result
                print("status isss \(result)")
            case .failure(let error):
                self?.userStatus = nil
                print("error getting status")
            }
        })
    }
    
    private func getController(with userStatus: UserStatus?) -> UIViewController? {
        guard let offerStatus = userStatus?.status else {
            print("smth went really wrong")
            return nil }
        switch offerStatus {
        case .create:
            print("create")
            return OfferSellBuySegmentedController()
        case .offerCreated:
            print("created")
            guard let offerСreatedData = userStatus?.data as? [OfferCreatedData] else { return nil }
            var offer: Offer?
            
            if let type = offerСreatedData.first?.type,
               let exchangeCurrency = offerСreatedData.first?.exchangeCurrency,
               let exchangeAmount = offerСreatedData.first?.exchangeAmount,
               let exchangeRate = offerСreatedData.first?.exchangeRate {
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
