//
//  OfferTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Nurbol on 17.07.2023.
//

import UIKit
import SkyFloatingLabelTextField
import SnapKit

final class OfferTableViewHeaderView: UITableViewHeaderFooterView {
    // MARK: - Public
    public static var reuseIdentifier = String(describing: OfferTableViewHeaderView.self)

    // MARK: - Properties
    private var exchangeAmount = 0.0 {
        didSet {
            sellBuyAmountLabel.text = String(exchangeAmount)
        }
    }
    private var currentExchangeRate = 0.0 {
        didSet {
            exchangeRateAmountLabel.text = String(currentExchangeRate)
            let multiplicationResult = String(format: "%.2f", currentExchangeRate * exchangeAmount)
            recievePayAmountLabel.text = multiplicationResult
        }
    }

    var changeButtonAction : ( ( ) -> Void)?

    // MARK: - UI
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        return containerView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявка"
        label.font = AppFont.semibold.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.tintColor = AppColor.gray80.uiColor
        button.titleLabel?.font = AppFont.medium.s14()
        button.addTarget(self, action: #selector (cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()

    private let sellBuycontainerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = AppColor.gray10.uiColor
        containerView.layer.borderColor = AppColor.gray20.uiColor.cgColor
        containerView.layer.borderWidth = 1
        return containerView
    }()
    private let recievePayContainerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = AppColor.gray10.uiColor
        containerView.layer.borderColor = AppColor.gray20.uiColor.cgColor
        containerView.layer.borderWidth = 1
        return containerView
    }()

    private let sellBuyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Продать"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    private let sellBuyAmountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let sellBuyCurrencySymbol: UILabel = {
        let label = UILabel()
        label.text = "$"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()

    private let recievePayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Получить"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()

    private let recievePayAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "250 000"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let recievePayCurrencySymbolLabel: UILabel = {
        let label = UILabel()
        label.text = "₸"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let exchangeRateContainerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = AppColor.gray10.uiColor
        containerView.layer.borderColor = AppColor.gray20.uiColor.cgColor
        containerView.layer.borderWidth = 1
        return containerView
    }()
    private let exchangeRateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "По курсу"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    private let exchangeRateAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "500"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let exchangeRateCurrencySymbolLabel: UILabel = {
        let label = UILabel()
        label.text = "₸"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.tintColor = AppColor.primaryBase.uiColor
        button.titleLabel?.font = AppFont.medium.s14()
        button.addTarget(self,
                         action: #selector(changeButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    @objc func changeButtonDidPressed() {
        changeButtonAction?()
    }
    
    @objc func cancelButtonDidPressed() {
        
    }
    
    public func setupHeader(with offer: Offer, symbol: String) {
        sellBuyCurrencySymbol.text = symbol
        sellBuyTitleLabel.text = offer.type == "SELL" ? "Продать" : "Купить"
        recievePayTitleLabel.text = offer.type == "SELL" ? "Получить" : "Заплатить"
        
        currentExchangeRate = offer.exchangeRate
        exchangeAmount = (offer.exchangeAmount)
        
        let multiplicationResult = String(format: "%.3f", offer.exchangeRate * offer.exchangeAmount)
        recievePayAmountLabel.text = multiplicationResult
    }
    public func setExchangeRate(rate: Double) {
        currentExchangeRate = rate
    }
    
    public func getExchangeRateAndExchangeAmount() -> (exchangeRate: Double, exchangeAmount: Double) {
        (currentExchangeRate, exchangeAmount)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [sellBuyTitleLabel, sellBuyAmountLabel, sellBuyCurrencySymbol].forEach {
            sellBuycontainerView.addSubview($0)
        }
        [recievePayTitleLabel, recievePayAmountLabel, recievePayCurrencySymbolLabel].forEach {
            recievePayContainerView.addSubview($0)
        }
        [exchangeRateTitleLabel, exchangeRateAmountLabel,
         exchangeRateCurrencySymbolLabel, changeButton].forEach {
            exchangeRateContainerView.addSubview($0)
        }
        [titleLabel, cancelButton,
         sellBuycontainerView, recievePayContainerView, exchangeRateContainerView].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
        contentView.backgroundColor =  AppColor.gray10.uiColor
    }
    // MARK: - Setup Constraints
    // swiftlint:disable all
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }
        sellBuycontainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo((UIScreen.main.bounds.width - 80)/2)
            make.height.equalTo(56)
        }
        recievePayContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(sellBuycontainerView.snp.trailing).offset(16)
            make.width.equalTo((UIScreen.main.bounds.width - 80)/2)
            make.height.equalTo(56)
        }
        [sellBuycontainerView, recievePayContainerView].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(16)
                make.leading.equalTo(sellBuycontainerView.snp.trailing).offset(16)
                make.width.equalTo((UIScreen.main.bounds.width - 80)/2)
                make.height.equalTo(56)
            }
        }
        [sellBuyTitleLabel, recievePayTitleLabel, exchangeRateTitleLabel].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(9.5)
                make.leading.equalToSuperview().offset(16)
                make.height.equalTo(16)
                make.width.equalTo(70)
            }
        }
        [sellBuyAmountLabel, recievePayAmountLabel, exchangeRateAmountLabel].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(25.5)
                make.leading.equalToSuperview().offset(16)
                make.height.equalTo(20)
            }
        }
        sellBuyCurrencySymbol.snp.makeConstraints { make in
            make.top.equalTo(sellBuyTitleLabel.snp.bottom)
            make.leading.equalTo(sellBuyAmountLabel.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        recievePayCurrencySymbolLabel.snp.makeConstraints { make in
            make.top.equalTo(recievePayTitleLabel.snp.bottom)
            make.leading.equalTo(recievePayAmountLabel.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        exchangeRateCurrencySymbolLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateTitleLabel.snp.bottom)
            make.leading.equalTo(exchangeRateAmountLabel.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        exchangeRateContainerView.snp.makeConstraints { make in
            make.top.equalTo(sellBuycontainerView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
        changeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }

    }
    // swiftlint:enable all
}
