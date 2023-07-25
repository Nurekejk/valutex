//
//  OfferSellViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit

final class OfferSellViewController: UIViewController {
    // MARK: - Properties
    
    private var upperTextFieldNumber = "0"
    private var lowerTextFieldNumber = "0"
    
    enum ControllerMode {
        case buy
        case sell
    }
    
    var mode: ControllerMode
    
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
    private lazy var sellLabel: UILabel = {
        let label = UILabel()
        
        label.text = mode == .buy ? "Купить" : "Продать"
        
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "По курсу"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private let sellCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: true, tag: 1)
        return currencyView
    }()
    private let exchangeRateCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: false, tag: 2)
        return currencyView
    }()
    
    private let lowerBorderView: UIView = {
        let view = UIView()
        return view
    }()
    private let getLabel: UILabel = {
        let label = UILabel()
        label.text = "Получить"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    private let getTotalLabel: UILabel = {
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
    }
    // MARK: - Initializer

    init(mode: ControllerMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        exchangeRateCurrencyView.delegate = self
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
}
// MARK: - CurrencySelectorViewControllerDelegate
extension OfferSellViewController: CurrencySelectorViewControllerDelegate, OfferSellCurrencyViewDelegate {
    
    func calculateOffer(sender: UITextField) {
        print(sender.tag)
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
