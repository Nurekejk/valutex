//
//  RegistrationPersonalDataViewController.swift
//  kurs.kz
//
//  Created by Adil on 02.07.2023.
//

import UIKit
import SnapKit

class RegistrationPersonalDataViewController: UIViewController {
    
    let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        return textField
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        return textField
    }()
    
    
    let patronymicTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        return textField
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        return textField
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemCyan
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        view.addSubview(surnameTextField)
        view.addSubview(nameTextField)
        view.addSubview(patronymicTextField)
        view.addSubview(phoneTextField)
        view.addSubview(emailTextField)
        view.addSubview(continueButton)
    }
    
    
    private func setupConstraints() {


        surnameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(56)
//            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(56)
        }
        
        patronymicTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(56)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(patronymicTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(56)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(56)
        }
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }

    }
    


}
