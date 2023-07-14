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
    
    private lazy var titleOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Валюта"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    private lazy var titletTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "Покупка"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    private lazy var titleThreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Продажа"
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstriats()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    func setupViews() {
        
        contentView.backgroundColor = .white
        contentView.addSubview(titleOneLabel)
        contentView.addSubview(titletTwoLabel)
        contentView.addSubview(titleThreeLabel)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstriats() {
        
        titleOneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
        titletTwoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(titleThreeLabel.snp.leading).offset(-33)
        }
        
        titleThreeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
