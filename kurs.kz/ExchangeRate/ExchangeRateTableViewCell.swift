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
    
    let USDFlagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        // image.image = UIImage(named: "USDFlag")
        return image
    }()
    
    private lazy var currencyUSDLabel: UILabel = {
        let label = UILabel()
        label.text = "Доллар"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var amountOfPurchaseUSDTextField: UITextField = {
        let textField = UITextField()
        textField.text = "500"
        textField.font = .systemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var amountOfSaleUSDTextField: UITextField = {
        let textField = UITextField()
        textField.text = "500"
        textField.font = .systemFont(ofSize: 16)
        return textField
    }()
    private lazy var deleteCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        if let iconImage = UIImage(named: "deleteCurrency") {
            button.setImage(iconImage, for: .normal)
        }
        //        let iconConfig = UIImage.SymbolConfiguration(pointSize: 16)
        //        let deleteIcon = UIImage(systemName: "deleteCurrency")?.withConfiguration(iconConfig)
        //        button.setImage(deleteIcon, for: .normal)
        //        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(deleteCurrencyButtonDidPressed),
                         for: .touchUpInside)
        
        return button
    }()
    
    //    let deleteButton = UIButton(type: .system)
    //    let iconConfig = UIImage.SymbolConfiguration(pointSize: 24)
    //    let deleteIcon = UIImage(systemName: "trash")?.withConfiguration(iconConfig)
    //    deleteButton.setImage(deleteIcon, for: .normal)
    //    deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    
    //    private lazy var signInButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.setTitle("Войти", for: .normal)
    //        button.setTitleColor(.white, for: .normal)
    //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    //        button.clipsToBounds = true
    //        button.backgroundColor = .systemBlue
    //        button.addTarget(self, action: #selector(signInButtonDidPressed), for: .touchUpInside)
    //        return button
    //    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with image: UIImage, and label: String) {
        self.USDFlagImage.image = image
        self.currencyUSDLabel.text = label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 8
        amountOfPurchaseUSDTextField.layer.cornerRadius = 10
        amountOfPurchaseUSDTextField.layer.borderWidth = 1
        amountOfPurchaseUSDTextField.layer.borderColor = UIColor.gray.cgColor
        amountOfSaleUSDTextField.layer.cornerRadius = 10
        amountOfSaleUSDTextField.layer.borderWidth = 1
        amountOfSaleUSDTextField.layer.borderColor = UIColor.gray.cgColor
    }
    // MARK: - Setup Views
    
    private func setupViews() {
        [currencyUSDLabel, USDFlagImage, amountOfPurchaseUSDTextField, amountOfSaleUSDTextField,
         deleteCurrencyButton].forEach {
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
        USDFlagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-301)
        }
        currencyUSDLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-196)
        }
        amountOfPurchaseUSDTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(163)
            make.trailing.equalToSuperview().offset(-116)
            make.height.equalTo(32)
        }
        amountOfSaleUSDTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(235)
            make.trailing.equalToSuperview().offset(-44)
            make.height.equalTo(32)
        }
        deleteCurrencyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(315)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(16)
        }
    }
    
    // MARK: - Actions
    
    @objc private func deleteCurrencyButtonDidPressed() {
        
    }
}
