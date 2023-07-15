//
//  OfferSellViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit

final class OfferSellViewController: UIViewController {
    // MARK: - Properties
    
    var upperTextFieldNumber = "0"
    var lowerTextFieldNumber = "0"
    
    private let currenciesDictionary = ["Доллар США" : ("usd_flag", "USD", "$"),
                                        "Евро" : ("euro_flag", "EUR", "€"),
                                        "Рос.рубль" : ("ru_flag", "RUB", "₽"),
                                        "Кирг.сом" : ("kgs_flag", "KGS", "c"),
                                        "Кит.юань" : ("cn_flag", "CNY", "¥")]
    
    private let currenciesKeyArray = ["Доллар США",
                                      "Евро",
                                      "Рос.рубль",
                                      "Кирг.сом",
                                      "Кит.юань"]
    
    private let buttonBlueColor = UIColor(
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1)
    
    private let borderGrayColor = UIColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1)
    
    private let backgroundGrayColor = UIColor(
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1)
    
    private let textGrayColor = UIColor(
        red: 147.0 / 255.0,
        green: 153.0 / 255.0,
        blue: 171.0 / 255.0,
        alpha: 1)

    // MARK: - UI
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    private let sellLabel: UILabel = {
        let label = UILabel()
        label.text = "Продать"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "По курсу"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    let sellCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: true)
        return currencyView
    }()
    let exchangeRateCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: false)
        return currencyView
    }()
    
    let lowerBorderView: UIView = {
        let view = UIView()
        return view
    }()
    let getLabel: UILabel = {
        let label = UILabel()
        label.text = "Получить"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    let getTotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    private lazy var offerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = buttonBlueColor
        button.setTitle("Предложить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        sellCurrencyView.changeCurrency(newFlagImage: "usd_flag",
                                        newCurrencyLabel: "USD",
                                        newCurrencySignLabel: "$")
        exchangeRateCurrencyView.changeCurrency(newFlagImage: "kzt_flag",
                                                newCurrencyLabel: "KZT",
                                                newCurrencySignLabel: "₸" )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.cornerRadius = 8
 
        sellCurrencyView.layer.borderWidth = 1
        sellCurrencyView.layer.borderColor = borderGrayColor.cgColor
        sellCurrencyView.layer.cornerRadius = 8
        
        exchangeRateCurrencyView.layer.borderWidth = 1
        exchangeRateCurrencyView.layer.borderColor = borderGrayColor.cgColor
        exchangeRateCurrencyView.layer.cornerRadius = 8
        
        sellLabel.textColor = textGrayColor
        exchangeRateLabel.textColor = textGrayColor
        getLabel.textColor = textGrayColor
        lowerBorderView.backgroundColor = borderGrayColor
        
        getTotalLabel.layer.cornerRadius = 8
        getTotalLabel.layer.borderWidth = 1
        getTotalLabel.layer.borderColor = borderGrayColor.cgColor
        getTotalLabel.backgroundColor = backgroundGrayColor
        
        offerButton.layer.cornerRadius = 12

        sellCurrencyView.amountTextField.tag = 1
        exchangeRateCurrencyView.amountTextField.tag = 2
        sellCurrencyView.amountTextField.addTarget(self,
                                                   action: #selector(calculateOffer(sender:)),
                                                   for: .editingChanged)
        exchangeRateCurrencyView.amountTextField.addTarget(self,
                                                           action: #selector(calculateOffer(sender:)),
                                                           for: .editingChanged)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = backgroundGrayColor
        sellLabel.textColor = borderGrayColor
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        [sellCurrencyView,
         exchangeRateCurrencyView,
         sellLabel,
         exchangeRateLabel,
         lowerBorderView,
         getLabel,
         getTotalLabel,
         offerButton].forEach { containerView.addSubview($0) }
         sellCurrencyView.delegate = self
    }
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(430)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(116)
        }
        sellLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.top.equalTo(containerView.snp.top).offset(80)
            make.height.equalTo(18)
        }
        sellCurrencyView.snp.makeConstraints { make in
            make.top.equalTo(sellLabel.snp.bottom).offset(4)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(311)
        }
        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(sellCurrencyView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(18)
        }
        exchangeRateCurrencyView.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom).offset(4)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(311)
        }
        lowerBorderView.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateCurrencyView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(1)
            make.width.equalTo(311)
        }
        getLabel.snp.makeConstraints { make in
            make.top.equalTo(lowerBorderView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(18)
        }
        getTotalLabel.snp.makeConstraints { make in
            make.top.equalTo(getLabel.snp.bottom).offset(4)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(311) }
        offerButton.snp.makeConstraints { make in
            make.top.equalTo(getTotalLabel.snp.bottom).offset(24)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(52)
            make.width.equalTo(311)
        }
    }
    // MARK: - Action
    @objc func calculateOffer(sender: UITextField) {
        if sender.tag == 1 {
            upperTextFieldNumber = sender.text ?? "0"
        } else {
            lowerTextFieldNumber = sender.text ?? "0"
        }
        let firstNumber = Double(upperTextFieldNumber) ?? 0.0
        let secondNumber = Double(lowerTextFieldNumber) ?? 0.0
        let sum = String(format: "%.3f", firstNumber * secondNumber)
            .trimmingCharacters(in: ["0", "."])
        if sum != "" {
            
           var trimmedResult = String(format: "%.3f", firstNumber * secondNumber)
                .trimmingCharacters(in: ["0"])
            if trimmedResult.last == "." {
                trimmedResult.removeLast()
            }
            getTotalLabel.text = trimmedResult
        } else {
            getTotalLabel.text = "0"
        }
    }
}
// MARK: - CurrencySelectorViewControllerDelegate
extension OfferSellViewController: CurrencySelectorViewControllerDelegate, OfferSellCurrencyViewDelegate {
    
    func selectorButtonPressed() {
        let modalScreen = CurrencySelectorViewController()
        modalScreen.delegate = self
        self.presentPanModal(modalScreen)
    }
    
    func currencyDidSelect(selectedIndexPath: IndexPath, isSearching: Bool, searchArray: [String]) {
        let modalScreen = CurrencySelectorViewController()
        modalScreen.delegate = self
        let newKey: String
        if !isSearching {
            newKey = currenciesKeyArray[selectedIndexPath.row]
        } else {
            newKey = searchArray[selectedIndexPath.row]
        }
        if let unwrappedTuple = currenciesDictionary[newKey] {
            sellCurrencyView.changeCurrency(newFlagImage: unwrappedTuple.0,
                           newCurrencyLabel: unwrappedTuple.1,
                           newCurrencySignLabel: unwrappedTuple.2)
        }
    }
    
}
