//
//  CalculatorTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit

final class CalculatorTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - UI

        private lazy var purchaseLabel: UILabel = {
            let label = UILabel()
            label.text = "Покупка"
            label.textColor = .lightGray
            label.font = .systemFont(ofSize: 10)
            return label
        }()
        private lazy var arrowUpButton: UIButton = {
            let button = UIButton(type: .system)
            let iconImage = UIImage(named: "arrow-up")
            button.setImage(iconImage, for: .normal)
            button.addTarget(self, action: #selector(arrowUpButtonDidPressed),
                             for: .touchUpInside)
            return button
        }()
        private lazy var sellLabel: UILabel = {
            let label = UILabel()
            label.text = "Продажа"
            label.textColor = .lightGray
            label.font = .systemFont(ofSize: 10)
            return label
        }()
        private lazy var arrowDownButton: UIButton = {
            let button = UIButton(type: .system)
            let iconImage = UIImage(named: "arrow-down")
            button.setImage(iconImage, for: .normal)
            button.addTarget(self, action: #selector(arrowDownButtonDidPressed),
                             for: .touchUpInside)
            return button
        }()

        // MARK: - LifeCycle

        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setupViews()
            setupConstraints()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Setup Views

        private func setupViews() {
            [purchaseLabel, sellLabel, arrowUpButton, arrowDownButton].forEach {
                contentView.addSubview($0)
            }
            contentView.backgroundColor = .white
        }
        // MARK: - Setup Constraints

        func setupConstraints() {
            arrowDownButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().offset(-5)
            }
            sellLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.trailing.equalTo(arrowDownButton.snp.leading).offset(-4)
            }
            arrowUpButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.trailing.equalTo(sellLabel.snp.leading).offset(-17.5)
            }
            purchaseLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(12)
                make.trailing.equalTo(arrowUpButton.snp.leading).offset(-4)
            }
        }

        // MARK: - Actions

        @objc private func arrowUpButtonDidPressed() {

        }
        @objc private func arrowDownButtonDidPressed() {

        }
    }
