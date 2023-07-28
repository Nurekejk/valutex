//
//  ChangeExchangeRateViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 24.07.2023.
//

import UIKit

class ChangeExchangeRateViewController: UIViewController {
    // MARK: - UI
    private let modalview: UIView = {
        let modalview = UIView()
        modalview.backgroundColor = .white
        modalview.layer.cornerRadius = 8
        return modalview
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажите новый курс"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector (cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "500"
        return textField
    }()
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.tintColor = AppColor.gray40.uiColor
        button.backgroundColor = AppColor.gray20.uiColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        return button
    }()
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = AppColor.grayWhite.uiColor
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        return button
    }()
    private let changeView: UIView = {
        let modalview = UIView()
        modalview.layer.borderWidth = 1
        modalview.layer.borderColor = AppColor.gray30.cgColor
        modalview.layer.cornerRadius = 8
        return modalview
    }()
    private let changeStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .equalCentering
        return stack
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.tintColor = AppColor.gray50.uiColor
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = AppColor.gray30.cgColor
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector (cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()
    private let confirmChangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("изменить", for: .normal)
        button.tintColor = AppColor.grayWhite.uiColor
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()

    private let textfield: UITextField = {
        let textfield = UITextField()
        return textfield
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

    }
    
    // MARK: - Setup Views

    private func setupViews() {
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(closeButton)

        changeStack.addArrangedSubview(minusButton)
        changeStack.addArrangedSubview(textField)
        changeStack.addArrangedSubview(plusButton)

        changeView.addSubview(changeStack)

        modalview.addSubview(headerStack)
        modalview.addSubview(changeView)
        modalview.addSubview(cancelButton)
        modalview.addSubview(confirmChangeButton)
        view.addSubview(modalview)

    }
    // MARK: - Setup Constraints

    private func setupConstraints() {
        let buttonWidth = (UIScreen.main.bounds.width - 44)/2
        modalview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(522)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        headerStack.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        changeView.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        changeStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        minusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(40)
        }
        plusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(40)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(40)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(changeView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(52)
        }
        confirmChangeButton.snp.makeConstraints { make in
            make.top.equalTo(changeView.snp.bottom).offset(16)
            make.leading.equalTo(cancelButton.snp.trailing).offset(12)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(52)
        }

    }

    // MARK: - Actions
    @objc func cancelButtonDidPressed() {
        self.dismiss(animated: true)
    }

}
