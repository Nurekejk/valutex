//
//  RegistrationPersonalDataViewController.swift
//  kurs.kz
//
//  Created by Adil on 02.07.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

class RegistrationPersonalDataViewController: UIViewController {
    
    //MARK: - Colors:
    
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
    
    //MARK: - Elements:
    
    let stackView: UIStackView = {
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
    
    let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        return container
    }()
    
    let placeholderSwitchView: UIView = {
        let placeholderSwitchView = UIView()
        return placeholderSwitchView
    }()
    

    
    let surnameTextField: paddedTextField = {
        let textField = paddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.title = "Фамилия"
        textField.placeholder = "Фамилия"
        return textField
    }()
    
    let nameTextField: paddedTextField = {
        let textField = paddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.title = "Имя"
        textField.placeholder = "Имя"
        return textField
    }()
    
    
    let patronymicTextField: paddedTextField = {
        let textField = paddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.title = "Отчество"
        textField.placeholder = "Отчество"
        return textField
    }()
    
    let phoneTextField: paddedTextField = {
        let textField = paddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.title = "Телефон"
        textField.placeholder = "Телефон"
        return textField
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
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
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        stackView.addArrangedSubview(placeholderSwitchView)
        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(patronymicTextField)
        stackView.addArrangedSubview(phoneTextField)

        containerView.addSubview(continueButton)
        
        view.addSubview(containerView)
        view.addSubview(stackView)
        
        view.backgroundColor = registrationGrayColor
        placeholderSwitchView.backgroundColor = registrationBlueColor
        continueButton.backgroundColor = registrationBlueColor

        
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

//MARK: - Custom Classes:

class paddedTextField: SkyFloatingLabelTextField {

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
}
