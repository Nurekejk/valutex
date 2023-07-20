//
//  SignupViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.07.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import InputMask

final class SignUpViewController: UIViewController {
    
    // MARK: - UI
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = AppFont.bold.s28()
        label.textColor = AppColor.gray100.uiColor
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - MaskedTextField Listener
        private lazy var listener: MaskedTextFieldDelegate = {
            let listener = MaskedTextFieldDelegate()
            listener.onMaskedTextChangedCallback = { textField, _, isFilled in
                let updatedText = textField.text ?? ""
                if isFilled {
                    print("Text field is filled: \(updatedText)")
                }
            }
            listener.delegate = self
            listener.primaryMaskFormat = "+7 ([000]) [000] [00] [00]"
            return listener
    }()
    
    private let phoneTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        
        textField.title = "Телефон"
        textField.placeholder = "+7 777 777 00 00"
        textField.titleColor = AppColor.gray50.uiColor
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.placeholderColor = AppColor.gray100.uiColor
        
        textField.titleLabel.font = AppFont.regular.s12()
        textField.placeholderFont = AppFont.regular.s16()
        textField.font = AppFont.regular.s16()
        
        textField.keyboardType = .phonePad
        textField.setTitleVisible(true)
        
        textField.titleFormatter = { $0 } // autocapitalizes the title
        textField.selectedTitle = "Телефон"
        textField.lineView.isHidden = true
        
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = AppFont.bold.s16()
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.tintColor = .white
        button.addTarget(self, action: #selector(continueButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private let isThereAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас есть аккаунт?"
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray50.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let myAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.medium.s16(),
            .foregroundColor: AppColor.primaryBase.uiColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributeString = NSMutableAttributedString(
            string: "Войти",
            attributes: myAttributes
        )
        
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        phoneTextField.layer.borderColor = AppColor.grayWhite.cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = 12
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: AppImage.arrow_back.uiImage,
                        style: .plain,
                        target: self,
                        action: #selector(backButtonDidPressed))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        [signUpLabel, phoneTextField, continueButton, isThereAccountLabel, signUpButton].forEach {
            view.addSubview($0)
        }
        phoneTextField.delegate = listener
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        signUpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(24)
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
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
        }
        
        isThereAccountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(18)
        }
    }
    
    // MARK: - Actions
    @objc private func continueButtonDidPressed() {
        self.navigationController?.pushViewController(VerificationPageViewController(), animated: true)
    }
    
    @objc private func signUpButtonDidPressed() {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
