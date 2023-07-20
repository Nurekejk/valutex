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
        textField.titleColor = AppColor.mediumGray.uiColor
        textField.selectedTitleColor = AppColor.mediumGray.uiColor

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
        textField.titleColor = AppColor.mediumGray.uiColor
        textField.selectedTitleColor = AppColor.mediumGray.uiColor

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

    private let maintextField: NurbolTextField = {
        let textField =  NurbolTextField()
        textField.titleFormatter = {$0}
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.title = "По курсу"
        textField.titleColor = AppColor.mediumGray.uiColor
        textField.selectedTitleColor = AppColor.mediumGray.uiColor

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
        changeButton.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
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

final class NurbolTextField: SkyFloatingLabelTextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding: CGFloat = 16.0
        let rightViewWidth: CGFloat = 24.0
        let rightViewHeight: CGFloat = 24.0
        let middlePointAdjuster = (bounds.height - rightViewHeight) / 2.0
        let rightBounds = CGRect(x: bounds.width - rightViewWidth - padding,
                                 y: middlePointAdjuster,
                                 width: rightViewWidth,
                                 height: rightViewHeight)
        return rightBounds
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let trimValue: CGFloat = 30
        let rightViewWidth: CGFloat = 40
        return CGRect(x: 10, y: 0, width: bounds.width - rightViewWidth - trimValue, height: bounds.height)
    }

    let padding = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
//
//    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }

    override public func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 16, y: 8, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 100, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
}
