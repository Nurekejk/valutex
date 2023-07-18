//
//  ApplicationTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit

final class ApplicationTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: ApplicationTableViewCell.self)
    
    // MARK: - UI
    private lazy var partnerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aidos Tazhigulov"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yellow-star")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4 (10)"
        label.textColor = UIColor(named: "partnerOfferGrayTextColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var partnerNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+7(707) 303-22-00"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var buyingLabel: UILabel = {
        let label = UILabel()
        label.text = "Покупает: "
        label.textColor = UIColor(named: "partnerOfferGrayTextColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var buyingSumLabel: UILabel = {
        let label = UILabel()
        label.text = "250 500 ₸  "
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "по курсу: "
        label.textColor = UIColor(named: "partnerOfferGrayTextColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var currencySumLabel: UILabel = {
        let label = UILabel()
        label.text = "500$"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var currencyInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "cancelButtonColor")
        button.setTitle("Отклонить", for: .normal)
        button.setTitleColor(UIColor(named: "cancelButtonTitleColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return button
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "acceptButtonColor")
        button.setTitle("Принять", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var offerYourCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Предложить свой курс", for: .normal)
        button.setTitleColor(UIColor(named: "offerCurrencyTextColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
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
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        cancelButton.layer.cornerRadius = 8.0
        acceptButton.layer.cornerRadius = 8.0
        offerYourCurrencyButton.layer.borderColor = UIColor(named: "offerCurrencyBorderColor")?.cgColor
        offerYourCurrencyButton.layer.borderWidth = 1.0
        offerYourCurrencyButton.layer.cornerRadius = 8.0
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .white
        [partnerNameStackView,
         phoneNumberLabel,
         currencyInformationStackView,
         buttonsStackView,
         offerYourCurrencyButton].forEach {
            contentView.addSubview($0)
        }
        
        [buyingLabel, buyingSumLabel, currencyLabel, currencySumLabel].forEach {
            currencyInformationStackView.addArrangedSubview($0)
        }
        
        [partnerNameLabel, starImageView, ratingLabel].forEach {
            partnerNameStackView.addArrangedSubview($0)
        }
        
        [cancelButton, acceptButton].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        partnerNameStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(partnerNameLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
        }
        
        currencyInformationStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(currencyInformationStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(151.5)
            make.height.equalTo(42)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.width.equalTo(151.5)
            make.height.equalTo(42)
        }
        
        offerYourCurrencyButton.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(319)
            make.height.equalTo(42)
        }
    }
}
