//
//  SignupViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.07.2023.
//

import UIKit

class SignupViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()

    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+7 777 777 00 00"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(named: "signupButtonColor")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstriants()
    }

    private func setupViews() {
        view.addSubview(label)
        view.addSubview(phoneTextField)
        view.addSubview(button)
    }

    private func setupConstriants() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }


        button.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
    }
}
