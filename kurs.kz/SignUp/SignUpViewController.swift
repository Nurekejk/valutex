//
//  SignupViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

final class SignUpViewController: UIViewController {
    
    // MARK: - UI
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        label.textColor = UIColor(named: "signUpLabelColor")
        label.textAlignment = .center
        return label
    }()
    
    private let phoneTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        
        textField.title = "Телефон"
        textField.placeholder = "+7 777 777 00 00"
        textField.titleColor = UIColor(named: "selectedTitleColor")!
        textField.selectedTitleColor = UIColor(named: "selectedTitleColor")!
        textField.placeholderColor = UIColor(named: "phoneNumberColor")!
        
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.font = UIFont.systemFont(ofSize: 16.0)
        
        textField.keyboardType = .phonePad
        textField.setTitleVisible(true)
        
        textField.titleFormatter = { $0 } // autocapitalizes the title
        textField.selectedTitle = "Телефон"
        
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel!.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "signupButtonColor")
        button.tintColor = .white
        button.addTarget(self, action: #selector(continueButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private let isThereAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас есть аккаунт?"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor(named: "defaultTextColor")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let myAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor(named: "signupButtonColor") ?? .blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(
            string: "Войти",
            attributes: myAttributes
        )
        
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        phoneTextField.layer.borderColor = UIColor(named: "phoneTextFieldBorderColor")?.cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = 12
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: UIImage(named: "arrow_back"),
                        style: .plain,
                        target: self,
                        action: #selector(backButtonDidPressed))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        [signUpLabel, phoneTextField, continueButton, isThereAccountLabel, signUpButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        signUpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
        }
        
        isThereAccountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(18)
        }
    }
    
    // MARK: - Actions
    @objc private func continueButtonDidPressed() {
        self.navigationController?.pushViewController(VerificationPageViewController(), animated: true)
    }
    
    @objc private func signUpButtonDidPressed() {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
