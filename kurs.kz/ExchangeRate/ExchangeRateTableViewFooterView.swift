//
//  ExchangeRateTableViewFooterView.swift
//  kurs.kz
//
//  Created by Акерке on 18.07.2023.
//

import UIKit

final class ExchangeRateTableViewFooterView: UITableViewHeaderFooterView {

    // MARK: - UI
    
    private lazy var addCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить валюту", for: .normal)
        button.addTarget(self, action: #selector(addCurrencyButtonDidPressed),
                         for: .touchUpInside)
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
        contentView.addSubview(addCurrencyButton)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstriats() {
        addCurrencyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    // MARK: - Actions

    @objc private func addCurrencyButtonDidPressed() {

    }
}
