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
        
        contentView.addSubview(titleOneLabel)
        contentView.addSubview(titletTwoLabel)
        contentView.addSubview(titleThreeLabel)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstriats() {
        
        titleOneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(12)
        }
        
        titletTwoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(12)
        }
        
        titleThreeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(12)
        }
    }
}
