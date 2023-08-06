//
//  ExchangeDollarTableViewCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 14.07.2023.
//

import UIKit
import SnapKit

final class CurrencyInformationTableViewCell: UITableViewCell {
    
    // MARK: - Public
    static var reuseIdentifier = String(describing: CurrencyInformationTableViewCell.self)
    
    var currency: CurrencyElement? {
        didSet {
            currencyImageLabel.text = currency?.currencyFlag
            currencyNameLabel.text = currency?.currencyCode
            currencySubtitleLabel.text = "1 доллар"
            if let buyPrice = currency?.buyPrice {
                buyLabel.text = String(buyPrice)
            }
            if let sellPrice = currency?.sellPrice {
                sellLabel.text = String(sellPrice)
            }
        }
    }
    
    // MARK: - UI
    private let currencyImageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.semibold.s14()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    private lazy var currencySubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular.s10()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    private lazy var sellLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.bold.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    private lazy var buyLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.bold.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    // MARK: - Life Cycle
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
        contentView.addSubview(currencyImageLabel)
        contentView.addSubview(currencyNameLabel)
        contentView.addSubview(currencySubtitleLabel)
        contentView.addSubview(sellLabel)
        contentView.addSubview(buyLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        currencyImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        currencyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(currencyImageLabel.snp.trailing).offset(8)
        }
        
        currencySubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(currencyNameLabel.snp.bottom)
            make.leading.equalTo(currencyImageLabel.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-12)
            make.width.equalTo(167)
        }
        
        buyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalTo(currencySubtitleLabel.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-17)
        }
        
        sellLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-17)
        }
    }
}
