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
    private var buttonIsEnabled = false
    private let service = CreateOfferService()

    private let type: String
    private var exchangeCurrency = "USD"
    private var exchangeAmount = 0.0
    private var exchangeRate = 0.0

    enum ControllerMode {
        case buy
        case sell
    }

    var mode: ControllerMode

    // MARK: - UI
    private lazy var modalScreen = CurrencySelectorViewController()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.grayWhite.uiColor
        return view
    }()
    private lazy var sellLabel: UILabel = {
        let label = UILabel()
        label.text = mode == .buy ? "Купить" : "Продать"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
        return label
    }()

    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "По курсу"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
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
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
        return label
    }()
    private let getTotalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColor.primaryBase.uiColor
        label.font = AppFont.semibold.s16()
        label.backgroundColor = AppColor.gray10.uiColor
        return label
    }()
    private lazy var offerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.primaryBase.uiColor.withAlphaComponent(0.64)
        button.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        button.setTitle("Предложить", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.addTarget(self, action: #selector(nextButtonDidPress), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

        sellCurrencyView.changeCurrency(newFlagImage: "🇺🇸",
                                        newCurrencyLabel: "USD",
                                        newCurrencySignLabel: "$")
        exchangeRateCurrencyView.changeCurrency(newFlagImage: "🇰🇿",
                                                newCurrencyLabel: "KZT",
                                                newCurrencySignLabel: "₸" )
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        containerView.layer.cornerRadius = 8

        sellCurrencyView.layer.borderWidth = 1
        sellCurrencyView.layer.borderColor = AppColor.gray20.cgColor
        sellCurrencyView.layer.cornerRadius = 8

        exchangeRateCurrencyView.layer.borderWidth = 1
        exchangeRateCurrencyView.layer.borderColor = AppColor.gray20.cgColor
        exchangeRateCurrencyView.layer.cornerRadius = 8

        getTotalLabel.layer.cornerRadius = 8
        getTotalLabel.layer.borderWidth = 1
        getTotalLabel.layer.borderColor = AppColor.gray20.cgColor

        offerButton.layer.cornerRadius = 12
    }
    // MARK: - Initializer

    init(mode: ControllerMode) {
        self.mode = mode
        self.type = mode == .buy ? "BUY" : "SELL"
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor

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
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(343)
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
    func currencyDidSelectInCalculator(currency: Currency, position: ButtonPosition) {
    }

    func currencyDidSelect(currency: Currency) {
        sellCurrencyView.changeCurrency(newFlagImage: currency.flag,
                                        newCurrencyLabel: getCurrencyName(currency,
                                                                          language: selectedLanguage),
                                        newCurrencySignLabel: currency.symbol)
        exchangeCurrency = currency.code
    }

    func calculateOffer(sender: UITextField) {
        if sender.tag == 1 {
            upperTextFieldNumber = sender.text ?? "0"
        } else {
            lowerTextFieldNumber = sender.text ?? "0"
        }
        let firstNumber = Double(upperTextFieldNumber) ?? 0.0
        let secondNumber = Double(lowerTextFieldNumber) ?? 0.0
        exchangeAmount = firstNumber
        exchangeRate = secondNumber
        let sum = String(format: "%.3f", firstNumber * secondNumber)
            .trimmingCharacters(in: ["0", "."])
        if sum != "" {
            buttonIsEnabled = true
            offerButton.backgroundColor = AppColor.primaryBase.uiColor
            var trimmedResult = String(format: "%.3f", firstNumber * secondNumber)
                .trimmingCharacters(in: ["0"])
            if trimmedResult.last == "." {
                trimmedResult.removeLast()
            }
            getTotalLabel.text = trimmedResult
        } else {
            getTotalLabel.text = "0"
            buttonIsEnabled = false
            offerButton.backgroundColor = AppColor.primaryBase.uiColor.withAlphaComponent(0.64)
        }
    }

    func selectorButtonPressed() {
        modalScreen.delegate = self
        self.presentPanModal(modalScreen)
    }

    @objc private func nextButtonDidPress() {
        let offer = Offer(type: type,
                          exchangeСurrency: exchangeCurrency,
                          exchangeAmount: exchangeAmount,
                          exchangeRate: exchangeRate)
        service.createOffer(offer: offer) { result in
            switch result {
            case .success((let data)):
                print("SUCCESS", data)
                self.navigationController?.pushViewController(
                    OfferViewController(offer: offer), animated: true)
            case .failure((let error)):
                print("ERROR", error)
            }
        }
    }
}
