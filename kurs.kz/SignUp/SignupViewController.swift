//
//  SignupViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

final class SignupViewController: UIViewController {

    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()

    private let phoneTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "Телефон"
        textField.placeholder = "+7 777 777 00 00"
        textField.titleColor = UIColor(named: "selectedTitleColor")!
        textField.selectedTitleColor = UIColor(named: "selectedTitleColor")!
        textField.layer.borderColor = UIColor(named: "phoneTextFieldBorderColor")?.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(named: "signupButtonColor")
        button.tintColor = .white
        button.layer.cornerRadius = 12
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
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(named: "signupButtonColor"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstriants()
    }

    private func setupViews() {
        view.addSubview(registrationLabel)
        view.addSubview(phoneTextField)
        view.addSubview(continueButton)
        view.addSubview(isThereAccountLabel)
        view.addSubview(signInButton)
    }

    private func setupConstriants() {
        registrationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(registrationLabel.snp.bottom).offset(24)
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
        
        isThereAccountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(18)
        }
        
        signInButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
        }
    }
    
    // MARK: - Actions
        
        @objc private func continueButtonDidPressed() {
            self.navigationController?.pushViewController(VerificationPageViewController(), animated: true)
        }
}
