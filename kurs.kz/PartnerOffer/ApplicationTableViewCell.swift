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
        [partnerNameStackView, phoneNumberLabel, currencyInformationStackView].forEach {
            contentView.addSubview($0)
        }
        
        [buyingLabel, buyingSumLabel, currencyLabel, currencySumLabel].forEach {
            currencyInformationStackView.addArrangedSubview($0)
        }
        
        [partnerNameLabel, starImageView, ratingLabel].forEach {
            partnerNameStackView.addArrangedSubview($0)
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
    }
}
