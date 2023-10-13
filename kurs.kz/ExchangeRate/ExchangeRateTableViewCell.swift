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
    
    // MARK: - UI

    private lazy var flagImageLabel: UILabel = {
        let imageLabel = UILabel()
        imageLabel.text = ""
        imageLabel.font = AppFont.regular.s16()
        return imageLabel
    }()
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Доллар"
        label.font = AppFont.regular.s16()
        return label
    }()
    private lazy var amountOfPurchaseTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.rightViewMode = .always
        textField.textAlignment = .center
        textField.font = AppFont.regular.s16()
        textField.text = "500"
        return textField
    }()
    private lazy var amountOfSaleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.rightViewMode = .always
        textField.textAlignment = .center
        textField.font = AppFont.regular.s16()
        textField.text = "500"
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
            
        }
        amountOfPurchaseTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(amountOfSaleTextField.snp.leading).offset(-8)
            make.height.equalTo(32)
        }
        amountOfSaleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(trashButton.snp.leading).offset(-16)
            make.height.equalTo(32)
        }
        trashButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(16)
        }
    }
    
    // MARK: - Actions
    
    @objc private func trashButtonDidPressed() {
        
    }
    
    // MARK: - Public
    
    public func configureCell(flagImage: String,
                              currencyLabel: String,
                              buyRate: Double?,
                              sellRate: Double?) {
        self.flagImageLabel.text = flagImage
        self.currencyLabel.text = currencyLabel
        if let unwrappedBuyRate = buyRate {
            self.amountOfPurchaseTextField.placeholder = unwrappedBuyRate.avoidNotation
        } else {
            self.amountOfPurchaseTextField.placeholder = "?"
        }
        if let unwrappedSellRate = sellRate {
            self.amountOfPurchaseTextField.placeholder = unwrappedSellRate.avoidNotation
        } else {
            self.amountOfPurchaseTextField.placeholder = "?"
        }
    }
}
