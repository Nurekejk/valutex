//
//  SignInViewController.swift
//  kurs.kz
//
//  Created by Akerke on 01.07.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import InputMask

final class SignInViewController: UIViewController {
    // MARK: - State

    private let service = SignInService()
    public static let defaultsIsAuthorizedKey = "isAutorized"
    public static let defaultsTokensKey = "accessTokens"

    // MARK: - UI

    private lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.bold.s28()
        return label
    }()

    // MARK: - MaskedTextField Listener
    
    private lazy var listener: MaskedTextFieldDelegate = {
        let listener = MaskedTextFieldDelegate()
        listener.onMaskedTextChangedCallback = { textField, _, isFilled in
            let updatedText = textField.text ?? ""
            if isFilled {
                print("Text field is filled: \(updatedText)")
            }
        }
        listener.delegate = self
        listener.primaryMaskFormat = "+7 ([000]) [000] [00] [00]"
        return listener
    }()
    
    private lazy var phoneTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()

        textField.placeholder = "Телефон"
        textField.placeholderColor = AppColor.gray50.uiColor
        textField.placeholderFont = AppFont.regular.s16()

        textField.title = "Телефон"
        textField.titleColor = UIColor.lightGray
        textField.titleLabel.font = AppFont.regular.s12()
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.textColor = AppColor.gray100.uiColor
        
        textField.keyboardType = .phonePad
        textField.lineView.isHidden = true
        return textField

    }()

    private lazy var passwordTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()

        textField.placeholder = "Пароль"
        textField.placeholderColor = AppColor.gray50.uiColor
        textField.placeholderFont = AppFont.regular.s16()

        textField.title = "Пароль"
        textField.titleColor = UIColor.lightGray
        textField.titleLabel.font = AppFont.regular.s12()
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.textColor = AppColor.gray100.uiColor
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.lineView.isHidden = true
        return textField

    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль", for: .normal)
        button.setTitleColor(AppColor.gray50.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.regular.s16()
        button.addTarget(self, action: #selector(forgotPasswordButtonDidPressed), for: .touchUpInside)
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFont.bold.s16()
        button.clipsToBounds = true
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.addTarget(self, action: #selector(signInButtonDidPressed), for: .touchUpInside)
        return button
    }()

    private lazy var signUpAskLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы еще не зарегистрированы?"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let titleString = NSAttributedString(string: "Зарегистрироваться",
                                             attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(titleString, for: .normal)
        button.setTitleColor(AppColor.primaryBase.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.regular.s16()
        button.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstriants()
        phoneTextField.delegate = listener
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        phoneTextField.layer.cornerRadius = 8
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.borderColor = AppColor.grayWhite.cgColor
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = AppColor.grayWhite.cgColor
        signInButton.layer.cornerRadius = 12

    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .white
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
        let phoneNumber = phoneTextField.text
        let password = passwordTextField.text
        guard let phoneNumber = phoneNumber,
              let password = password else {
            showSnackBar(message: "Номер телефона или пароль введены неправильно.")
            return
        }

        if phoneNumber.isEmpty {
            showSnackBar(message: "Пожалуйства, введите свой номер.")
            return
        }

        if phoneNumber.count != 18 {
            showSnackBar(message: "Номер телефона введен неправильно.")
            return
        }

        let formatedPhoneNumber = phoneNumber
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")

        service.signIn(phone: formatedPhoneNumber, password: password) { result in
            switch result {
            case .success(let data):
                
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: SignInViewController.defaultsIsAuthorizedKey)

                if let data = try? JSONEncoder().encode(data) {
                    defaults.setValue(data, forKey: SignInViewController.defaultsTokensKey)
                } else {
                    print("error while encoding")
                }
                let tabbarController = MainTabBarViewController()
                tabbarController.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(tabbarController, animated: true)
            case .failure:
                DispatchQueue.main.async {
                    self.showSnackBar(message: "Ошибка! Убедитесь, что вы ввели правильный номер.")
                }
            }
        }
    }
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - SnackBar

    private func showSnackBar(message: String) {
        SnackBarController.showSnackBar(in: view, message: message, duration: .lengthLong)
    }
    @objc private func signUpButtonDidPressed() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}
