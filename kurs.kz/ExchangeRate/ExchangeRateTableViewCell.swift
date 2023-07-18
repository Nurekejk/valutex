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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "USDflag")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Доллар"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var amountOfPurchaseTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.text = "500"
        return textField
    }()
    
    private lazy var amountOfSaleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.text = "500"
        return textField
    }()
    private lazy var trashButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(named: "trash")
        button.setImage(iconImage, for: .normal)
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
// MARK: - Layers

    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 8
        amountOfPurchaseTextField.layer.cornerRadius = 10
        amountOfPurchaseTextField.layer.borderWidth = 1
        amountOfPurchaseTextField.layer.borderColor = UIColor.gray.cgColor
        amountOfSaleTextField.layer.cornerRadius = 10
        amountOfSaleTextField.layer.borderWidth = 1
        amountOfSaleTextField.layer.borderColor = UIColor.gray.cgColor
    }
    // MARK: - Setup Views
    
    private func setupViews() {
        [currencyLabel, flagImage, amountOfPurchaseTextField, amountOfSaleTextField,
         trashButton].forEach {
            containerView.addSubview($0)
        }
        contentView.backgroundColor = .systemGray6
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
        }
        flagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(12)

        }
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(58)

        }
        amountOfPurchaseTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(163)
            make.trailing.equalToSuperview().offset(-116)
            make.height.equalTo(32)
        }
        amountOfSaleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(235)
            make.trailing.equalToSuperview().offset(-44)
            make.height.equalTo(32)
        }
        trashButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(315)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(16)
        }
    }
    
    // MARK: - Actions
    
    @objc private func trashButtonDidPressed() {
        
    }
    // MARK: - Public

        public func configureCell(nameImage: String, nameTitle: String) {
            flagImage.image = UIImage(named: nameImage)
            currencyLabel.text = nameTitle
        }
    }
