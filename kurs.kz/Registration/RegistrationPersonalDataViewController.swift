//
//  RegistrationPersonalDataViewController.swift
//  kurs.kz
//
//  Created by Adil on 02.07.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

final class RegistrationPersonalDataViewController: UIViewController {
    
    // MARK: - UI

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                     leading: 20,
                                                                     bottom: 20,
                                                                     trailing: 20)
        stackView.backgroundColor = AppColor.grayWhite.uiColor
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = AppColor.grayWhite.uiColor
        return container
    }()

    private let surnameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.title = "Фамилия"
        textField.titleColor = AppColor.gray50.uiColor
        textField.placeholder = "Фамилия"
        textField.textColor = AppColor.gray100.uiColor
        return textField
    }()
    
    private let nameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.title = "Имя"
        textField.titleColor = AppColor.gray50.uiColor
        textField.placeholder = "Имя"
        textField.textColor = AppColor.gray100.uiColor
        return textField
    }()
    
    private let patronymicTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.title = "Отчество"
        textField.titleColor = AppColor.gray100.uiColor
        textField.placeholder = "Отчество"
        textField.textColor = AppColor.gray100.uiColor
        return textField
    }()
    
    private let phoneTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.lineView.isHidden = true
        textField.titleFormatter = { (text: String) -> String in
            if #available(iOS 9.0, *) {
                return text
            } else {
                return text
            }
        }
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.title = "Телефон"
        textField.titleColor = AppColor.gray50.uiColor
        textField.placeholder = "Телефон"
        textField.textColor = AppColor.gray100.uiColor
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font =  AppFont.bold.s16()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(continueButtonDidPress), for: .touchUpInside)
        return button
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
        self.edgesForExtendedLayout = []
        self.navigationItem.title = "Регистрация"
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "arrow_back"),
                            style: .plain,
                            target: self,
                            action: #selector(backButtonDidPress))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(patronymicTextField)
        stackView.addArrangedSubview(phoneTextField)

        containerView.addSubview(continueButton)
        
        view.addSubview(containerView)
        view.addSubview(stackView)
        
        view.backgroundColor = AppColor.gray10.uiColor
        continueButton.backgroundColor = AppColor.primaryBase.uiColor
    }
    
    override func viewDidLayoutSubviews() {
        surnameTextField.layer.borderColor = AppColor.grayWhite.cgColor
        nameTextField.layer.borderColor = AppColor.grayWhite.cgColor
        patronymicTextField.layer.borderColor = AppColor.grayWhite.cgColor
        phoneTextField.layer.borderColor = AppColor.grayWhite.cgColor
    }
    // MARK: - Constraints:
    private func setupConstraints() {

        surnameTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        patronymicTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(316)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        containerView.snp.makeConstraints { make in
            make.height.equalTo(118)
            make.leading.trailing.bottom.equalToSuperview()
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }

    // MARK: - Actions

    @objc private func backButtonDidPress() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func continueButtonDidPress() {
        self.navigationController?.pushViewController(RegistrationPasswordViewController(), animated: true)
    }
}
