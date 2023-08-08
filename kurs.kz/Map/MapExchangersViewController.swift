//
//  MapExchangeViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 06.08.2023.
//

import UIKit
import Pulley

final class MapExchangersViewController: PulleyViewController {

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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
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
}

// MARK: - CurrencySelectorViewControllerDelegate
extension MapExchangersViewController: CurrencySelectorViewControllerDelegate {
    func currencyDidSelect(currency: Currency) {
        navigationBarView.changeCurrency(newFlagImage: currency.flag,
                                         newCurrencyLabel: currency.code)
    }
}
