//
//  ExchangeRateTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 12.07.2023.
//

import UIKit
import SnapKit

final class ExchangeRateTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public static var reuseIdentifier = String(describing: ExchangeRateTableViewCell.self)
    
    // MARK: - Properties
    var deleteAction: (() -> Void)?
    var updateAction: ((CurrencyElementForExchangeRateVC) -> Void)?
    private var index: Int?
    private var currency: CurrencyElementForExchangeRateVC? {
        didSet {
            self.flagImageLabel.text = currency?.currencyFlag
            self.currencyLabel.text = currency?.currencyRuName
            if let unwrappedBuyRate = currency?.buyPrice {
                self.amountOfPurchaseTextField.text = unwrappedBuyRate.avoidNotation
            }
            if let unwrappedSellRate = currency?.sellPrice {
                self.amountOfSaleTextField.text = unwrappedSellRate.avoidNotation

            }
        }
    }
    
    // MARK: - UI
    private lazy var flagImageLabel: UILabel = {
        let imageLabel = UILabel()
        imageLabel.text = ""
        imageLabel.font = AppFont.regular.s16()
        return imageLabel
    }()
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = AppFont.regular.s16()
        label.textAlignment = .left
        return label
    }()
    private lazy var amountOfPurchaseTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tag = 0
        textField.rightViewMode = .always
        textField.textAlignment = .center
        textField.delegate = self
        textField.font = AppFont.regular.s16()
        textField.textColor = AppColor.gray100.uiColor
        textField.text = ""
        return textField
    }()
    private lazy var amountOfSaleTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.borderStyle = .roundedRect
        textField.rightViewMode = .always
        textField.textAlignment = .center
        textField.delegate = self
        textField.textColor = AppColor.gray100.uiColor
        textField.font = AppFont.regular.s16()
        textField.text = ""
        return textField
    }()
    private lazy var trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.trash.uiImage, for: .normal)
        button.addTarget(self, action: #selector(trashButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    
    private func setupViews() {
        [currencyLabel, flagImageLabel, amountOfPurchaseTextField, amountOfSaleTextField,
         trashButton].forEach {
            contentView.addSubview($0)
        }
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        flagImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(12)
        }
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(flagImageLabel.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualTo(amountOfPurchaseTextField.snp.leading)
        }
        amountOfPurchaseTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(64)
            make.trailing.equalTo(amountOfSaleTextField.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        amountOfSaleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(64)
            make.trailing.equalTo(trashButton.snp.leading).offset(-16)
            make.height.equalTo(32)
        }
        trashButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-12)
            make.size.equalTo(16)
        }
    }
    
    // MARK: - Actions
    @objc private func trashButtonDidPressed() {
        deleteAction?()
    }
    
    public func getIndex() -> Int? {
        index
    }
    
    public func configureCell(currency: CurrencyElementForExchangeRateVC,
                              index: Int) {
        self.currency = currency
    }
}

extension ExchangeRateTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let unwrappedValue = textField.text else { return }
        if textField.tag == 0 {
            currency?.buyPrice = Double(unwrappedValue)
        } else {
            currency?.sellPrice =  Double(unwrappedValue)
        }
        if let unwrappedCurrency = currency {
            updateAction?(unwrappedCurrency)
        }
    }
}
