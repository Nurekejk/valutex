//
//  NotificationsTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 11.07.2023.
//

import UIKit
import SnapKit

final class NotificationsTableViewCell: UITableViewCell {
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тех. поддержка"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var textField: UITextField = {
            let textField = UITextField()
            textField.backgroundColor = .systemGray6
            textField.textAlignment = .left
            textField.placeholder = "Добро пожаловать в службу поддержки"
            return textField
        }()

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
        contentView.addSubview(titleLabel)

    }

    // MARK: - Setup Constraints

    private func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-40)

    }
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-40)
        }

