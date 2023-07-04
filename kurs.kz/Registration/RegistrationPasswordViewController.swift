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
        //when using margins, they won't scale depending on device. Should i use container view instead?
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

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.configuration?.contentInsets = .init()
        button.backgroundColor = .cyan
        return button
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        return container
    }()
    
    private let enterPasswordButton = showHideTextButton()
    
    private let repeatPasswordButton = showHideTextButton()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Пароль должен состоять из латинских букв и цифр"
        label.textColor = .systemGray
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
    
    private let repeatPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.rightViewMode = .always
        textField.placeholder = "Повторите пароль"
        return textField
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        view.backgroundColor = .white
        elementsStackView.backgroundColor = .white
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(elementsStackView)
        view.addSubview(containerView)
        elementsStackView.addArrangedSubview(passwordStackView)
        elementsStackView.addArrangedSubview(textLabel)
        passwordStackView.addArrangedSubview(enterPasswordTextField)
        passwordStackView.addArrangedSubview(repeatPasswordTextField)
        containerView.addSubview(continueButton)
        
        enterPasswordTextField.rightView = enterPasswordButton
        repeatPasswordTextField.rightView = repeatPasswordButton

    }
    
    //MARK: - Constraints:
    private func setupConstraints() {
        elementsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(232)
        }
        textLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(118)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.height.equalTo(52)
        }
    }
}



final class PasswordTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding = 16.0
        let iconWidth = 24.0
        let iconHeight = 24.0
        let middlePointAdjuster = (bounds.height - iconHeight) / 2.0
        let rightBounds = CGRect(x: bounds.width - iconWidth - padding, y: middlePointAdjuster, width: iconWidth, height: iconHeight)
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
