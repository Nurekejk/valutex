//
//  ExchangeDollarTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 14.07.2023.
//

import UIKit
import SnapKit

final class ExchangeDollarTableViewHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UI
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Валюта"
        label.font = AppFont.regular.s10()
        return label
    }()
    
    private lazy var purchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Покупка"
        label.font = AppFont.regular.s10()
        return label
    }()
    
    private lazy var buyLabel: UILabel = {
        let label = UILabel()
        label.text = "Продажа"
        label.font = AppFont.regular.s10()
        return label
    }()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.backgroundColor = .white
        
        [currencyLabel, purchaseLabel, buyLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraitns
    func setupConstraints() {
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
        purchaseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(buyLabel.snp.leading).offset(-33)
        }
        
        buyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
