//
//  OfferTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Nurbol on 17.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

class OfferTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - Outlets

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        return containerView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявка"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "OrderLabel")
        return label
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return button
    }()

    private let selltextField: SkyFloatingLabelTextField = {
        let textField =  CustomSkyFloatingLabelTextField()
        textField.titleFormatter = {$0}
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.title = "Продать"
        textField.titleColor = UIColor(named: "selectedTitleColor")!
        textField.selectedTitleColor = UIColor(named: "selectedTitleColor")!

        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.placeholderColor = UIColor(named: "phoneNumberColor")!
        textField.placeholder = "5 000 $"

        textField.backgroundColor = .systemGray6
        textField.lineView.isHidden = true
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderColor = UIColor(named: "phoneTextFieldBorderColor")?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8

        textField.keyboardType = .phonePad
        textField.setTitleVisible(true)
        return textField
    }()
    
    private let buytextField: SkyFloatingLabelTextField = {
        let textField =  CustomSkyFloatingLabelTextField()
        textField.titleFormatter = {$0}
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.title = "Получить"
        textField.titleColor = UIColor(named: "selectedTitleColor")!
        textField.selectedTitleColor = UIColor(named: "selectedTitleColor")!

        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.placeholderColor = UIColor(named: "phoneNumberColor")!
        textField.placeholder = "250 000 т"

        textField.backgroundColor = .systemGray6
        textField.lineView.isHidden = true
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderColor = UIColor(named: "phoneTextFieldBorderColor")?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8

        textField.keyboardType = .phonePad
        textField.setTitleVisible(true)
        return textField
    }()

    private let maintextField: SkyFloatingLabelTextField = {
        let textField =  CustomSkyFloatingLabelTextField()
        textField.titleFormatter = {$0}
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.title = "По курсу"
        textField.titleColor = UIColor(named: "selectedTitleColor")!
        textField.selectedTitleColor = UIColor(named: "selectedTitleColor")!

        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.placeholderColor = UIColor(named: "phoneNumberColor")!
        textField.placeholder = "500 т"

        textField.backgroundColor = .systemGray6
        textField.lineView.isHidden = true
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderColor = UIColor(named: "phoneTextFieldBorderColor")?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.keyboardType = .phonePad
        textField.setTitleVisible(true)
        return textField
    }()

    private let changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return button
    }()

    // MARK: - Lifecycle

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
        maintextField.rightView = changeButton
        maintextField.rightViewMode = .always

        [titleLabel, cancelButton, selltextField, buytextField, maintextField].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
    }
    // MARK: - Setup Constraints

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }
        selltextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-193.5)
            make.height.equalTo(56)
        }
        buytextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(selltextField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        maintextField.snp.makeConstraints { make in
            make.top.equalTo(selltextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
    }
}
