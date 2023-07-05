//
//  SiginInViewController.swift
//  kurs.kz
//
//  Created by Akerke on 01.07.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

final class SiginInViewController: UIViewController {

    //MARK: - Outlets

    private lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()

    /*private lazy var phoneTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField(frame: CGRect(x: 150, y: 10, width: 120, height: 45))
        textField.placeholder = "Телефон"
        textField.title = "Телефон"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        /*textField.titleColor = UIColor.lightGray
        textField.selectedTitleColor = UIColor.lightGray
        textField.placeholderColor = UIColor.black
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.keyboardType = .phonePad
        textField.setTitleVisible(true)*/
        return textField
        /*textField.font = .systemFont(ofSize: 16)
        textField.layer.borderWidth = 1
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.rightViewMode = .always
        let imageView = UIImageView()
        let image = AppImage.check.uiImage
        imageView.image = image
        textField.rightView = imageView*/
    }()*/
    private lazy var phoneTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        textField.placeholder = "Телефон"
        textField.title = "Телефон"
        //textField.selectedLineColor = .lightGray
        textField.titleColor = UIColor.lightGray
        textField.selectedTitleColor = UIColor.lightGray
        textField.placeholderColor = UIColor.lightGray
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderColor = UIColor.gray.cgColor
        //textField.borderStyle = .roundedRect
       // textField.layer.borderWidth = 1
        //textField.layer.cornerRadius = 8
       // textField.keyboardType = .phonePad
       /* //textField.lineColor = .gray
        //textField.tintColor = .lightGray
        textField.textColor = .black
        //textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.keyboardType = .phonePad

        // Additional customizations
       textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
       textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.titleColor = .lightGray
        textField.selectedTitleColor = .lightGray
        textField.placeholderColor = .black
       // textField.lineHeight = 1.0
       // textField.selectedLineHeight = 1.0
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
       // textField.borderStyle = .roundedRect
       // textField.clipsToBounds = true
*/
        return textField
    }()


    private lazy var passwordTextField: CustomSkyFloatingLabelTextField = {
        let textField = CustomSkyFloatingLabelTextField()
        textField.title = "Пароль"
        textField.placeholder = "Пароль"
        textField.titleColor = UIColor.lightGray
        textField.selectedTitleColor = UIColor.lightGray
        textField.placeholderColor = UIColor.lightGray
        textField.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        textField.placeholderFont = UIFont.systemFont(ofSize: 16.0)
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderColor = UIColor.gray.cgColor
        //textField.borderStyle = .roundedRect
        //textField.layer.borderWidth = 1
       // textField.layer.cornerRadius = 8
        textField.keyboardType = .phonePad
        return textField
        /*let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.font = .systemFont(ofSize: 16)
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        return textField*/
    }()

    /*private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Забыли пароль"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()*/

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        //button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var signUpAskLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы еще не зарегистрированы?"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)

        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let titleString = NSAttributedString(string: "Зарегистрироваться", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(titleString, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupViews()
        setupConstriants()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        phoneTextField.layer.cornerRadius = 8
        phoneTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderWidth = 1
        signInButton.layer.cornerRadius = 12
    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(enterLabel)
        view.addSubview(phoneTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(signUpAskLabel)
        view.addSubview(signUpButton)
    }

    private func setupConstriants() {

        enterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(enterLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }

        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-24)
        }

        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }

        signUpAskLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(310)
            make.centerX.equalToSuperview()
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signUpAskLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()

        }

    }

    // MARK: - Actions

    @objc private func buttonPressed() {

    }
}
