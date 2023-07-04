//
//  RegistrationPersonalDataViewController.swift
//  kurs.kz
//
//  Created by Adil on 02.07.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField



final class RegistrationPersonalDataViewController: UIViewController {
    
    //MARK: - UI
    
    private let registrationGrayColor = UIColor (
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1 )
    
    private let registrationBlueColor = UIColor (
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1 )
    
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        return container
    }()

    private let surnameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = .gray
        textField.title = "Фамилия"
        textField.placeholder = "Фамилия"
        return textField
    }()
    
    private let nameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = .gray
        textField.title = "Имя"
        textField.placeholder = "Имя"
        return textField
    }()
    
    
    private let patronymicTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = .gray
        textField.title = "Отчество"
        textField.placeholder = "Отчество"
        return textField
    }()
    
    private let phoneTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = .gray
        textField.title = "Телефон"
        textField.placeholder = "Телефон"
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(patronymicTextField)
        stackView.addArrangedSubview(phoneTextField)

        containerView.addSubview(continueButton)
        
        view.addSubview(containerView)
        view.addSubview(stackView)
        
        view.backgroundColor = registrationGrayColor
        continueButton.backgroundColor = registrationBlueColor

        
    }
    //MARK: - Constraints:
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-312)
        }
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.top.equalTo(stackView.snp.bottom).offset(194)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
        }
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }
}

