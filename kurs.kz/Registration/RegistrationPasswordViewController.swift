//
//  RegistrationPasswordViewController.swift
//  kurs.kz
//
//  Created by Adil on 03.07.2023.
//


import UIKit
import SnapKit

class RegistrationPasswordViewController: UIViewController {
    
    //MARK: - UI
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
    
   
    
    // type .system?
    private let enterPasswordButton = showHideTextButton()
    private let repeatPasswordButton = showHideTextButton()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Пароль должен состоять из латинских букв и цифр"
        label.font = .systemFont(ofSize: 14, weight: .init(rawValue: 400))
        return label
    }()
    
    
    private let enterPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.rightViewMode = .always
        print("asdasdasd")
        textField.placeholder = "Пароль"
        
        return textField
    }()
    private let repeatPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.rightViewMode = .always
        print("asdasdasd")
        textField.placeholder = "Повторите пароль"
        return textField
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        view.backgroundColor = .gray
        elementsStackView.backgroundColor = .white
        placeholderSwitchView.backgroundColor = .blue
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(elementsStackView)
        elementsStackView.addArrangedSubview(placeholderSwitchView)
        elementsStackView.addArrangedSubview(passwordStackView)
        elementsStackView.addArrangedSubview(textLabel)
        passwordStackView.addArrangedSubview(enterPasswordTextField)
        passwordStackView.addArrangedSubview(repeatPasswordTextField)
        
        enterPasswordTextField.rightView = enterPasswordButton
        repeatPasswordTextField.rightView = repeatPasswordButton

    }
    
    //MARK: - Constraints:
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
    }
    
}



class PasswordTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding = 10.0
        let rightBounds = CGRect(x: bounds.width - bounds.height / 2.0 - padding, y: bounds.height/4, width: bounds.height / 2.0, height: bounds.height / 2.0)
            return rightBounds
    }
}


final class showHideTextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setImage(UIImage(named: "eye-slash"), for: .normal)
    }
    
}
