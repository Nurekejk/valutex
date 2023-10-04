//
//  MapExchangeViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 06.08.2023.
//

import UIKit
import Pulley
import GoogleMaps

final class MapExchangersViewController: PulleyViewController {
    private let defaults = UserDefaults.standard
    
    // MARK: - Public
    private let exchangeListController = ExchangeListViewController()
    private let mapViewController = MapViewController(service: ExchangerListService())
    
    private var currency: Currency? {
        didSet {
            exchangeListController.updateCurrency(newCurrency: currency)
        }
    }

    // MARK: - UI
    private lazy var navigationBarView: NavigationBarCurencyButtonView = {
        let view = NavigationBarCurencyButtonView()
        return view
    }()
    
    private lazy var navigationCurrencySelectButton: UIBarButtonItem = {
        let buttonTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectorPressed))
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 77, height: 24))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(buttonTapGesture)
        containerView.addSubview(navigationBarView)
        
        let button = UIBarButtonItem(customView: containerView)
        return button
    }()
    
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обменники"
        label.font = AppFont.medium.s18()
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(contentViewController: UIViewController = MapViewController(
        service: ExchangerListService()),
                  drawerViewController: UIViewController = ExchangeListViewController()) {
        super.init(contentViewController: mapViewController, drawerViewController: exchangeListController)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.drawerTopInset = 0
        self.drawerCornerRadius = 0
        self.allowsUserDrawerPositionChange = true
        mapViewController.delegate = self
        navigationBarView.changeCurrency(newFlagImage: "🇺🇸", newCurrencyLabel: "USD")
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = navigationCurrencySelectButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:
                                                                        navigationTitleLabel)
    }
    
    // MARK: - Action
    @objc func selectorPressed() {
        let modalScreen = CurrencySelectorViewController()
        modalScreen.delegate = self
        self.presentPanModal(modalScreen)
    }

    // MARK: - Storage
    func fetchDefaults() {
        if let data = defaults.data(forKey: ExchangeListViewController.defaultsCurrencyKey) {
            do {
                let fetchedCurrency = try JSONDecoder().decode(Currency.self, from: data)
                navigationBarView.changeCurrency(newFlagImage: fetchedCurrency.flag,
                                                 newCurrencyLabel: fetchedCurrency.code)
            } catch {
                print("error while decoding")
            }
        } else {
            return
        }
    }
}

// MARK: - CurrencySelectorViewControllerDelegate
extension MapExchangersViewController: CurrencySelectorViewControllerDelegate {

    func currencyDidSelect(currency: Currency) {
        self.currency = currency
        navigationBarView.changeCurrency(newFlagImage: currency.flag,
                                         newCurrencyLabel: currency.code)
        if let data = try? JSONEncoder().encode(currency) {
            defaults.setValue(data, forKey: ExchangeListViewController.defaultsCurrencyKey)
        } else {
            print("error while encoding")
        }
    }
}
// MARK: - MapViewControllerDelegate

extension MapExchangersViewController: MapViewControllerDelegate {
    func didUpdateLocation(location: CLLocation) {
        print("please work \(location)")
        exchangeListController.updateLocation(newLocation: location)
        print(location)
    }
}
