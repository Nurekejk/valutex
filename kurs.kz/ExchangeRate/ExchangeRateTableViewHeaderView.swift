//
//  ExchangeRateTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 18.07.2023.
//

import UIKit

class ExchangeRateTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - UI

    private lazy var purchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Покупка"
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    private lazy var sellLabel: UILabel = {
        let label = UILabel()
        label.text = "Продажа"
        label.font = .systemFont(ofSize: 10)
        return label
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

    private func setupViews() {
        [purchaseLabel, sellLabel].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .systemGray6
    }
        // MARK: - Setup Constraits

        func setupConstriats() {

            purchaseLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().offset(-33)
            }

            sellLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().offset(-16)
            }
        }
    }
