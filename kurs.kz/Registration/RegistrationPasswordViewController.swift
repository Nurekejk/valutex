//
//  RegistrationPasswordViewController.swift
//  kurs.kz
//
//  Created by Adil on 03.07.2023.
//

import UIKit
import SnapKit

final class RegistrationPasswordViewController: UIViewController {
    
    // MARK: - UI
    private let elementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 16,
                                                                     bottom: 16,
                                                                     trailing: 16)
        return stackView
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        return container
    }()
    
    private let enterPasswordButton = ShowHideTextButton()
    
    private let repeatPasswordButton = ShowHideTextButton()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Пароль должен состоять из латинских букв и цифр"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let enterPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.rightViewMode = .always
        textField.placeholder = "Пароль"
        return textField
    }()
    
    private let repeatPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.rightViewMode = .always
        textField.placeholder = "Повторите пароль"
        return textField
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        continueButton.layer.cornerRadius = 12
        elementsStackView.layer.cornerRadius = 8
        enterPasswordButton.layer.cornerRadius = 8
        repeatPasswordButton.layer.cornerRadius = 8
        passwordStackView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [elementsStackView, containerView].forEach { view.addSubview($0) }
        [passwordStackView, textLabel].forEach { elementsStackView.addArrangedSubview($0)}
        [enterPasswordTextField, repeatPasswordTextField].forEach { passwordStackView.addArrangedSubview($0) }
        containerView.addSubview(continueButton)
        
        enterPasswordTextField.rightView = enterPasswordButton
        repeatPasswordTextField.rightView = repeatPasswordButton
        
        view.backgroundColor = .systemGray5
        elementsStackView.backgroundColor = .white
        passwordStackView.backgroundColor = .white
        textLabel.textColor = .systemGray3
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = .cyan
        containerView.backgroundColor = .white
    }
    
    // MARK: - Constraints:
    private func setupConstraints() {
        elementsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(232)
        }
        textLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(118)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.height.equalTo(52)
        }
    }
}