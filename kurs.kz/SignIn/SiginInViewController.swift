//
//  SiginInViewController.swift
//  kurs.kz
//
//  Created by Akerke on 01.07.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

final class SiginInViewController: UIViewController {

    // MARK: - Outlets

    private lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()

    private lazy var phoneTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()

        textField.placeholder = "Телефон"
        textField.placeholderColor = UIColor.lightGray
        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)

        textField.title = "Телефон"
        textField.titleColor = UIColor.lightGray
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.selectedTitleColor = UIColor.lightGray

        textField.keyboardType = .phonePad
        textField.lineView.isHidden = true
        return textField

    }()

    private lazy var passwordTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()

        textField.placeholder = "Пароль"
        textField.placeholderColor = UIColor.lightGray
        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)

        textField.title = "Пароль"
        textField.titleColor = UIColor.lightGray
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.selectedTitleColor = UIColor.lightGray

        textField.keyboardType = .phonePad
        textField.lineView.isHidden = true
        return textField

    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(forgotPasswordButtonDidPressed), for: .touchUpInside)
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(signInButtonDidPressed), for: .touchUpInside)
        return button
    }()

    private lazy var signUpAskLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы еще не зарегистрированы?"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let titleString = NSAttributedString(string: "Зарегистрироваться", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(titleString, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupViews()
        setupConstriants()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        phoneTextField.layer.cornerRadius = 8
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        signInButton.layer.cornerRadius = 12

    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(enterLabel)
        view.addSubview(phoneTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(signUpAskLabel)
        view.addSubview(signUpButton)
    }

    private func setupConstriants() {

        enterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(enterLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }

        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-24)
        }

        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }

        signUpAskLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(310)
            make.centerX.equalToSuperview()
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signUpAskLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()

        }

    }

    // MARK: - Actions

    @objc private func forgotPasswordButtonDidPressed() {

    }

    @objc private func signInButtonDidPressed() {

    }

    @objc private func signUpButtonDidPressed() {
    
    }
}
