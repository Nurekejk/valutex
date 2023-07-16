//
//  ExchangeListTableViewCell.swift
//  kurs.kz
//
//  Created by MacBook on 16.07.2023.
//

import UIKit
import SnapKit

class ExchangeListTableViewCell: UITableViewCell {
    // MARK: - State
    static let identifier = "ExchangeListTableCell"
    
    public func configureCell(withValue currency: String, named iconName: String) {
        mainTitleLabel.text = currency
        iconImageView.image = UIImage(named: iconName)
    }

    // MARK: - UI
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let buyRateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let sellRateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [iconImageView, mainTitleLabel,
         ratingImageView, ratingLabel,
         addressLabel, dateLabel,
         buyRateLabel, sellRateLabel].forEach {contentView.addSubview($0)}
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17.5)
            make.leading.equalToSuperview().offset(12)
            make.size.equalTo(24)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(18)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
        }
        ratingImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalTo(mainTitleLabel.snp.trailing).offset(8)
            make.size.equalTo(12)
        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13.5)
            make.trailing.equalTo(ratingImageView.snp.trailing).offset(4)
            make.height.equalTo(15)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(2)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(18)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10.5)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(18)
        }
        sellRateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalTo(buyRateLabel.snp.leading).offset(-12)
            make.height.equalTo(20)
            make.width.equalTo(64)
        }
        buyRateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(20)
            make.width.equalTo(64)
        }
    }
}
