//
//  RegistrationPasswordViewController.swift
//  kurs.kz
//
//  Created by Adil on 03.07.2023.
//

import UIKit
import SnapKit

final class RegistrationPasswordViewController: UIViewController {
    
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
        button.titleLabel?.font = AppFont.bold.s16()
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(continueButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        return container
    }()
    
    private let enterPasswordButton = ShowHideTextButton()
    
    private let repeatPasswordButton = ShowHideTextButton()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Пароль должен состоять из латинских букв и цифр"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private let enterPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.textColor = AppColor.darkGray.uiColor
        textField.borderStyle = .roundedRect
        textField.rightViewMode = .always
        textField.placeholder = "Пароль"
        return textField
    }()
    
    private let repeatPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.textColor = AppColor.darkGray.uiColor
        textField.borderStyle = .roundedRect
        textField.rightViewMode = .always
        textField.placeholder = "Повторите пароль"
        return textField
    }()
    
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
        enterPasswordTextField.layer.borderColor = AppColor.lightGray.cgColor
        repeatPasswordButton.layer.cornerRadius = 8
        repeatPasswordTextField.layer.borderColor = AppColor.lightGray.cgColor
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
        
        view.backgroundColor = AppColor.backgroundGray.uiColor
        elementsStackView.backgroundColor = .white
        passwordStackView.backgroundColor = .white
        textLabel.textColor = AppColor.mediumGray.uiColor
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = AppColor.primaryBlue.uiColor
        containerView.backgroundColor = .white
    }
    
    // MARK: - Constraints:
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
        let controller = CustomTabBarViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func backButtonDidPress() {
        self.navigationController?.popViewController(animated: true)
    }
}
