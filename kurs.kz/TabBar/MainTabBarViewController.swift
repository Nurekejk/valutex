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
    private var userRole: String? {
        didSet {
            if userRole == "user" {
                checkStatus()
            } else if userRole == "owner" || userRole == "manager" {
                offerController = setupOwnerController()
                setupTabs()
            } else {
                print("smth went terribly wrong")
            }
        }
    }
    private var offerController: UIViewController?
    private var userStatus: UserStatus? {
        didSet {
            guard let unwrappedUserRole = userRole else { return }
            offerController = getController(with: userStatus)
            setupTabs()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUserRole()
        
        setupTabs()
        self.tabBar.barTintColor = AppColor.grayWhite.uiColor
        self.tabBar.tintColor = AppColor.primaryBase.uiColor
        self.tabBar.backgroundColor = .white
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
    
    private func retrieveUserRole() {
        if let data = defaults.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            do {
                let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
                if let role = tokens.user?.role {
                    userRole = role
                    print(userRole)
                }
            } catch {
                print("error while decoding")
            }
        }
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
    
    private func setupOwnerController() -> UIViewController {
        let controller = PartnerOfferViewController()
        return controller
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
                                       symbol: offerСreatedData.first?.currencySymbol,
                                       service: OfferService())
        case .offerAccepted:
            guard let offerСreatedData = userStatus?.data as? OfferAcceptedData else { return nil }
            print("accepted")
            if let status = offerСreatedData.statusType,
               let currency = offerСreatedData.exchangeCurrency,
               let exchangeRate = offerСreatedData.exchangeRate,
               let exchangeSum = offerСreatedData.exchangeSum,
               let exchangerTitle = offerСreatedData.exchangeOffice,
               let exchangeOfficeAddress = offerСreatedData.exchangeOfficeAddress {
                let detailsData = [status, String(currency),
                                   exchangeRate.avoidNotation + " ₸",
                                   exchangeSum.avoidNotation,
                                   exchangerTitle,
                                   exchangeOfficeAddress]
                return ClientOfferDetailsViewController(detailsData: detailsData,
                                                        service: ClientOfferDetailsService())
            } else {
                return nil
            }
        }
    }
}
