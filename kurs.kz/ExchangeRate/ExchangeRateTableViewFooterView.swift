//
//  ExchangeRateTableViewFooterView.swift
//  kurs.kz
//
//  Created by Акерке on 18.07.2023.
//

import UIKit

class ExchangeRateTableViewFooterView: UITableViewHeaderFooterView {

    // MARK: - UI
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить валюту", for: .normal)
        //        button.setTitleColor(blue, for: <#T##UIControl.State#>)
        return button
    }()
    
    // MARK: - LifeCycle
    
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
        contentView.addSubview(button)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstriats() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
