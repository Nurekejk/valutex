//
//  ExchangeRateTableViewFooterView.swift
//  kurs.kz
//
//  Created by Акерке on 18.07.2023.
//

import UIKit

final class ExchangeRateTableViewFooterView: UITableViewHeaderFooterView {

    // MARK: - State
    static let reuseID = String(describing: ExchangeRateTableViewFooterView.self)
    
    // MARK: - Properties
    var addCurrencyButtonAction: (() -> Void)?
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
        contentView.backgroundColor = AppColor.grayWhite.uiColor
        contentView.addSubview(addCurrencyButton)
    }
    
    // MARK: - Setup Constraits
    func setupConstriats() {
        addCurrencyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    // MARK: - Actions
    @objc private func addCurrencyButtonDidPressed() {
        addCurrencyButtonAction?()
    }
}
