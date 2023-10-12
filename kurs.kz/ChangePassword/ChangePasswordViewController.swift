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
    
    private lazy var newPasswordTextfield: SkyFloatingLabelTextField = {
        let textfield = factory.getPasswordTextfield(with: "Новый пароль")
        return textfield
    }()
    
    private lazy var repeatPasswordTextfield: SkyFloatingLabelTextField = {
        let textfield = factory.getRepeatPasswordTextfield()
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
    @objc func saveButtonDidPress() {

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
