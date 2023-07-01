//
//  SiginInViewController.swift
//  kurs.kz
//
//  Created by Nurgul on 01.07.2023.
//

import UIKit
import SnapKit

class SiginInViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .boldSystemFont(ofSize: 28)
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Телефон"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
//        textField.backgroundColor = .orange
        return textField
    }()


    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
//        textField.backgroundColor = .orange
        return textField
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .blue
//        textField.backgroundColor = .orange
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
        view.addSubview(passwordTextField)
        view.addSubview(button)
    }

    private func setupConstriants() {
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
////            label.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
////            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//

        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
//            make.centerX.equalToSuperview()
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
//            make.width.equalTo(327)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
//            make.width.equalTo(327)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
//            make.width.equalTo(327)
        }
    }

}
