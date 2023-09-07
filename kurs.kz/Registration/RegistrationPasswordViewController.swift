//
//  RegistrationPasswordViewController.swift
//  kurs.kz
//
//  Created by Adil on 03.07.2023.
//

import UIKit
import SnapKit
import ProgressHUD

final class RegistrationPasswordViewController: UIViewController {
    
    private let service: OtpRegistrationService
    private var user: User
    
    // MARK: - UI
    private let elementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 16,
                                                                     bottom: 16,
                                                                     trailing: 16)
        stackView.backgroundColor = AppColor.grayWhite.uiColor
        return stackView
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        button.addTarget(self, action: #selector(continueButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        return container
    }()
    
    private let enterPasswordButton: UIButton = {
        let button = ShowHideTextButton()
        button.addTarget(self, action:  #selector(enterPasswordButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private let repeatPasswordButton = ShowHideTextButton()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Пароль должен состоять из латинских букв и цифр"
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    private let enterPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.textColor = AppColor.gray100.uiColor
        textField.rightViewMode = .always
        textField.placeholder = "Пароль"
        return textField
    }()
    
    private let repeatPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.textColor = AppColor.gray100.uiColor
        textField.rightViewMode = .always
        textField.placeholder = "Повторите пароль"
        return textField
    }()
    
    // MARK: - Initializers
    init(service: OtpRegistrationService, user: User) {
        self.service = service
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        self.navigationItem.title = "Придумайте пароль"
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: AppImage.arrow_back.uiImage,
                            style: .plain,
                            target: self,
                            action: #selector(backButtonDidPress))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        continueButton.layer.cornerRadius = 12
        elementsStackView.layer.cornerRadius = 8

        enterPasswordButton.layer.cornerRadius = 8
        repeatPasswordButton.layer.cornerRadius = 8
        
        enterPasswordTextField.layer.borderColor = AppColor.gray20.cgColor
        enterPasswordTextField.layer.borderWidth = 1
        enterPasswordTextField.layer.cornerRadius = 8
        
        repeatPasswordTextField.layer.borderColor = AppColor.gray20.cgColor
        repeatPasswordTextField.layer.borderWidth = 1
        repeatPasswordTextField.layer.cornerRadius = 8
        
        passwordStackView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [elementsStackView, containerView].forEach { view.addSubview($0) }
        [passwordStackView, textLabel].forEach { elementsStackView.addArrangedSubview($0)}
        [enterPasswordTextField, repeatPasswordTextField].forEach { passwordStackView.addArrangedSubview($0) }
        containerView.addSubview(continueButton)
        
        enterPasswordTextField.rightView = enterPasswordButton
        repeatPasswordTextField.rightView = repeatPasswordButton
        
        view.backgroundColor = AppColor.gray10.uiColor

        passwordStackView.backgroundColor = AppColor.grayWhite.uiColor
        continueButton.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        continueButton.backgroundColor = AppColor.primaryBase.uiColor
        containerView.backgroundColor = AppColor.grayWhite.uiColor
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        elementsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(232)
        }
        textLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(118)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.height.equalTo(52)
        }
    }

    // MARK: - Actions

    @objc private func continueButtonDidPress() {
        guard let password = enterPasswordTextField.text else {
            self.showFailure()
            self.showSnackBar(message: "Пароль введен неправильно.")
            return
        }
        
        if password.isEmpty {
            self.showFailure()
            self.showSnackBar(message: "Пожалуйста, введите пароль.")
            return
        } else if password.count < 6 {
            self.showFailure()
            self.showSnackBar(message: "Пароль слишком короткий!")
            return
        }
        
        guard let passwordRepeated = repeatPasswordTextField.text else {
            self.showFailure()
            self.showSnackBar(message: "Повторный пароль введен неправильно.")
            return
        }
        
        if passwordRepeated.isEmpty {
            self.showFailure()
            self.showSnackBar(message: "Пожалуйста, повторите пароль.")
            return
        } else if password != passwordRepeated {
            self.showFailure()
            self.showSnackBar(message: "Пароли не совпадают.")
            return
        }
        
        user.setPassword(password: password)
        
        service.fetchUser(with: self.user) { result in
            switch result {
            case .success:
                self.showSuccess()
                let tabbarController = MainTabBarViewController()
                tabbarController.navigationItem.hidesBackButton = true
                tabbarController.modalPresentationStyle = .overFullScreen
                self.present(tabbarController, animated: true)
            case .failure:
                DispatchQueue.main.async {
                    self.showFailure()
                    self.showSnackBar(message: "Ошибка! Повторите еще раз.")
                }
            }
        }
    }

    @objc private func backButtonDidPress() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func enterPasswordButtonDidPress() {
        enterPasswordTextField.isSecureTextEntry = true
    }
    
    // MARK: - SnackBar
    private func showSnackBar(message: String) {
        SnackBarController.showSnackBar(in: view, message: message, duration: .lengthShort)
    }
}

// MARK: - ProgressHudProtocol
extension RegistrationPasswordViewController: ProgressHudProtocol {
    func showSuccess() {
        ProgressHUD.show(icon: .succeed)
    }
    
    func showFailure() {
        ProgressHUD.show(icon: .failed)
    }
}
