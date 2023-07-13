//
//  SignupViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

final class SignupViewController: UIViewController {

    // MARK: - UI
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
        
        textField.layer.borderColor = UIColor(named: "phoneTextFieldBorderColor")?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        
        textField.keyboardType = .phonePad
        textField.setTitleVisible(true)
        
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel!.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "signupButtonColor")
        button.tintColor = .white
        button.layer.cornerRadius = 12
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
    
    private lazy var signInButton: UIButton = {
        
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
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        self.navigationItem.title = "Регистрация"
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        [phoneTextField, continueButton, isThereAccountLabel, signInButton].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        phoneTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
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

        signInButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
        }
        
        isThereAccountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(18)
        }
    }
    
     // MARK: - Actions
        
    @objc private func continueButtonDidPressed() {
        self.navigationController?.pushViewController(VerificationPageViewController(), animated: true)
    }
}
