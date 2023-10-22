//
//  ChangePasswordViewController.swift
//  kurs.kz
//
//  Created by MacBook on 12.10.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

final class ChangePasswordViewController: UIViewController {
    
    // MARK: - Factory
    private let factory = SkyFloatingLabelTextfieldFactory()
    
    // MARK: - Properties
    private let service: AccountSettingsService

    // MARK: - UI
    private let passwordContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.grayWhite.uiColor
        return view
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var newPasswordTextfield: PasswordTextField = {
        let textfield = factory.getPasswordTextfield(with: "Новый пароль")
        textfield.button.addTarget(self, action: #selector(newPasswordButtonDidPress), for: .touchUpInside)
        return textfield
    }()
    
    private lazy var repeatPasswordTextfield: PasswordTextField = {
        let textfield = factory.getRepeatPasswordTextfield()
        textfield.button.addTarget(self, action: #selector(repeatPasswordButtonDidPress), for: .touchUpInside)
        return textfield
    }()
    
    private let passwordTipLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль должен состоять из латинских букв и цифр"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private let saveButtonContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = AppColor.grayWhite.uiColor
        return container
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupConstraints()
    }
    
    // MARK: - Initializers
    init(service: AccountSettingsService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        
        [newPasswordTextfield, repeatPasswordTextfield].forEach { passwordStackView.addArrangedSubview($0) }
        [passwordStackView, passwordTipLabel].forEach { passwordContainerView.addSubview($0) }

        saveButtonContainerView.addSubview(saveButton)

        [passwordStackView, passwordContainerView, saveButtonContainerView].forEach({view.addSubview($0)})
        
        passwordContainerView.backgroundColor = .white
        passwordContainerView.layer.cornerRadius = 8
        
        view.sendSubviewToBack(passwordContainerView)
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Смена пароля"
    }

    // MARK: - Action
    @objc private func saveButtonDidPress() {
        guard let password = newPasswordTextfield.text else {
            self.showAlert(message: "Пароль введен неправильно.")
            return
        }
        
        if password.isEmpty {
            self.showAlert(message: "Пожалуйста, введите пароль.")
            return
        } else if password.count < 6 {
            self.showAlert(message: "Пароль слишком короткий!")
            return
        }
        
        guard let passwordRepeated = repeatPasswordTextfield.text else {
            self.showAlert(message: "Повторный пароль введен неправильно.")
            return
        }
        
        if passwordRepeated.isEmpty {
            self.showAlert(message: "Пожалуйста, повторите пароль.")
            return
        } else if password != passwordRepeated {
            self.showAlert(message: "Пароли не совпадают.")
            return
        }
        service.updatePassword(
            newPassword: newPasswordTextfield.text!) { [weak self] result in
                switch result {
                case .success(let message):
                    print(message)
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func newPasswordButtonDidPress() {
        newPasswordTextfield.buttonIsSelected = !newPasswordTextfield.buttonIsSelected
        newPasswordTextfield.isSecureTextEntry = !newPasswordTextfield.buttonIsSelected
    }
    
    @objc private func repeatPasswordButtonDidPress() {
        repeatPasswordTextfield.buttonIsSelected = !repeatPasswordTextfield.buttonIsSelected
        repeatPasswordTextfield.isSecureTextEntry = !repeatPasswordTextfield.buttonIsSelected
    }

    // MARK: - Constraints
    private func setupConstraints() {
        
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(208)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.top).offset(16)
            make.height.equalTo(124)
            make.leading.equalTo(passwordContainerView.snp.leading).offset(16)
            make.trailing.equalTo(passwordContainerView.snp.trailing).offset(-16)
        }
        
        [newPasswordTextfield, repeatPasswordTextfield].forEach({$0.snp.makeConstraints { make in
            make.leading.equalTo(passwordStackView.snp.leading)
            make.trailing.equalTo(passwordStackView.snp.trailing)

        }})
        
        passwordTipLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordStackView.snp.bottom)
            make.leading.equalTo(passwordContainerView.snp.leading).offset(16)
            make.trailing.equalTo(passwordContainerView.snp.trailing).offset(-16)
            make.bottom.equalTo(passwordContainerView.snp.bottom)
        }

        saveButtonContainerView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(118)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(saveButtonContainerView.snp.top).offset(16)
            make.leading.equalTo(saveButtonContainerView.snp.leading).offset(16)
            make.trailing.equalTo(saveButtonContainerView.snp.trailing).offset(-16)
            make.height.equalTo(52)
        }
    }
}
