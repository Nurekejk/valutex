//
//  RegistrationPasswordViewController.swift
//  kurs.kz
//
//  Created by MacBook on 03.07.2023.
//

import Foundation

import UIKit
import SnapKit

class RegistrationPasswordViewController: UIViewController {
    
    private let elementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        return stackView
    }()


    
    private let containerView: UIView = {
        let container = UIView()
        return container
    }()
    
    
    private let placeholderSwitchView: UIView = {
        let placeholderSwitchView = UIView()
        return placeholderSwitchView
    }()
    
    private let showHideButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye-slash"), for: .normal)
        
//        button.frame = CGSize(width: 20, height: 20)
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //text is being cut off due to wrong font I think
        label.text = "Пароль должен состоять из латинских букв и цифр"
        label.font = .systemFont(ofSize: 14, weight: .init(rawValue: 400))
        return label
    }()
    
    
    private let enterPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.rightViewMode = .always
        textField.placeholder = "Пароль"
        
        return textField
    }()
    private let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.rightViewMode = .always
        textField.placeholder = "Повторите пароль"
        return textField
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        view.backgroundColor = .gray
        elementsStackView.backgroundColor = .white
        placeholderSwitchView.backgroundColor = .blue
        passwordStackView.backgroundColor = .yellow
        textLabel.backgroundColor = .green

        


        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        view.addSubview(elementsStackView)
        elementsStackView.addArrangedSubview(placeholderSwitchView)
        elementsStackView.addArrangedSubview(passwordStackView)
        elementsStackView.addArrangedSubview(textLabel)
        passwordStackView.addArrangedSubview(enterPasswordTextField)
        passwordStackView.addArrangedSubview(repeatPasswordTextField)
        
        enterPasswordTextField.rightView = showHideButton
        repeatPasswordTextField.rightView = showHideButton
    }

    private func setupConstraints() {
        elementsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-464)
        }
        placeholderSwitchView.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        textLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
        }

//        enterPasswordTextField.snp.makeConstraints { make in
//            make.top.equalTo(containerView.snp.top).offset(16)
//        }
    }
    
}



class PasswordTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding = 10.0
        let rightBounds = CGRect(x: bounds.width - bounds.height / 2.0 - padding, y: bounds.height/4, width: bounds.height / 2.0, height: bounds.height / 2.0)
            return rightBounds
    }
}



//            make.bottom.equalToSuperview().offset(0)
//            make.top.equalTo(stackView.snp.bottom).offset(194)



//
//
////MARK: - UI
//
//final class RegistrationPersonalDataViewController: UIViewController {
//
//
//    //MARK: - Colors:
//
//    private let registrationGrayColor = UIColor (
//        red: 246.0 / 255.0,
//        green: 247.0 / 255.0,
//        blue: 249.0 / 255.0,
//        alpha: 1 )
//
//    private let registrationBlueColor = UIColor (
//        red: 45.0 / 255.0,
//        green: 156.0 / 255.0,
//        blue: 219.0 / 255.0,
//        alpha: 1 )
//
//    //MARK: - Elements:
//
//    //container views:
//    private let stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 12
//        stackView.alignment = .fill
//        stackView.distribution = .fillEqually
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//        stackView.backgroundColor = .white
//        stackView.layer.cornerRadius = 8
//        return stackView
//    }()
//
//    private let containerView: UIView = {
//        let container = UIView()
//        container.backgroundColor = .white
//        return container
//    }()
//
//    private let placeholderSwitchView: UIView = {
//        let placeholderSwitchView = UIView()
//        return placeholderSwitchView
//    }()
//
//
//    //elements put in containers:
//    private let surnameTextField: PaddedTextField = {
//        let textField = PaddedTextField()
//        textField.borderStyle = .roundedRect
//        textField.layer.cornerRadius = 8
//        textField.lineView.isHidden = true
//        textField.titleFormatter = { (text: String) -> String in
//            if #available(iOS 9.0, *) {
//                return text
//            } else {
//                return text
//            }
//        }
//        textField.selectedTitleColor = .gray
//        textField.title = "Фамилия"
//        textField.placeholder = "Фамилия"
//        return textField
//    }()
//
//    private let nameTextField: PaddedTextField = {
//        let textField = PaddedTextField()
//        textField.borderStyle = .roundedRect
//        textField.layer.cornerRadius = 8
//        textField.lineView.isHidden = true
//        textField.titleFormatter = { (text: String) -> String in
//            if #available(iOS 9.0, *) {
//                return text
//            } else {
//                return text
//            }
//        }
//        textField.selectedTitleColor = .gray
//        textField.title = "Имя"
//        textField.placeholder = "Имя"
//        return textField
//    }()
//
//
//    private let patronymicTextField: PaddedTextField = {
//        let textField = PaddedTextField()
//        textField.borderStyle = .roundedRect
//        textField.layer.cornerRadius = 8
//        textField.lineView.isHidden = true
//        textField.titleFormatter = { (text: String) -> String in
//            if #available(iOS 9.0, *) {
//                return text
//            } else {
//                return text
//            }
//        }
//        textField.selectedTitleColor = .gray
//        textField.title = "Отчество"
//        textField.placeholder = "Отчество"
//        return textField
//    }()
//
//    private let phoneTextField: PaddedTextField = {
//        let textField = PaddedTextField()
//        textField.borderStyle = .roundedRect
//        textField.layer.cornerRadius = 8
//        textField.lineView.isHidden = true
//        textField.titleFormatter = { (text: String) -> String in
//            if #available(iOS 9.0, *) {
//                return text
//            } else {
//                return text
//            }
//        }
//        textField.selectedTitleColor = .gray
//        textField.title = "Телефон"
//        textField.placeholder = "Телефон"
//        return textField
//    }()
//
//    private let continueButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Продолжить", for: .normal)
//        button.titleLabel?.font =  .systemFont(ofSize: 16, weight: .bold)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 12
//        return button
//    }()
//
//    //MARK: - lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        setupConstraints()
//        // Do any additional setup after loading the view.
//    }

//    //MARK: - setup views
//    private func setupViews() {
//        //putting elements in the stack:
//        stackView.addArrangedSubview(placeholderSwitchView)
//        stackView.addArrangedSubview(surnameTextField)
//        stackView.addArrangedSubview(nameTextField)
//        stackView.addArrangedSubview(patronymicTextField)
//        stackView.addArrangedSubview(phoneTextField)
//
//        containerView.addSubview(continueButton)
//
//        view.addSubview(containerView)
//        view.addSubview(stackView)
//
//        //changing background colors:
//        view.backgroundColor = registrationGrayColor
//        placeholderSwitchView.backgroundColor = registrationBlueColor
//        continueButton.backgroundColor = registrationBlueColor
//
//
//    }
//    //MARK: - Constraints:
//    private func setupConstraints() {
//        stackView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(116)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//            make.bottom.equalToSuperview().offset(-312)
//        }
//        containerView.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(0)
//            make.top.equalTo(stackView.snp.bottom).offset(194)
//            make.leading.equalToSuperview().offset(0)
//            make.trailing.equalToSuperview().offset(0)
//        }
//        continueButton.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(-34-16)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//            make.height.equalTo(52)
//        }
//    }
//}
//
////MARK: - Custom Classes:
//
//class PaddedTextField: SkyFloatingLabelTextField {
//
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
//    }
//
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
//    }
//
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
//    }
//    override open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
//        if editing {
//            return CGRect(x: 5, y: 5, width: bounds.size.width, height: titleHeight())
//        }
//        return CGRect(x: 100, y: titleHeight(), width: bounds.size.width, height: titleHeight())
//    }
//}
