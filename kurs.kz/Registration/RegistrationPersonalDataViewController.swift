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
    
    private let service: OtpRegistrationService
    
    // MARK: - UI
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                     leading: 20,
                                                                     bottom: 20,
                                                                     trailing: 20)
        stackView.backgroundColor = AppColor.grayWhite.uiColor
        return stackView
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = AppColor.grayWhite.uiColor
        return container
    }()

    private let surnameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.lineView.isHidden = true
        textField.titleFormatter = { $0 }
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.title = "Фамилия"
        textField.titleColor = AppColor.gray50.uiColor
        textField.placeholder = "Фамилия"
        textField.textColor = AppColor.gray100.uiColor
        return textField
    }()
    
    private let nameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.lineView.isHidden = true
        textField.titleFormatter = { $0 }
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.title = "Имя"
        textField.titleColor = AppColor.gray50.uiColor
        textField.placeholder = "Имя"
        textField.textColor = AppColor.gray100.uiColor
        return textField
    }()
    
    private let patronymicTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.lineView.isHidden = true
        textField.titleFormatter = { $0 }
        textField.selectedTitleColor = AppColor.gray50.uiColor
        textField.title = "Отчество"
        textField.titleColor = AppColor.gray50.uiColor
        textField.placeholder = "Отчество"
        textField.textColor = AppColor.gray100.uiColor
        return textField
    }()
    
    private let phoneTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.lineView.isHidden = true
        textField.titleFormatter = { $0 }
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
        button.titleLabel?.font =  AppFont.semibold.s16()
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(continueButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    init(service: OtpRegistrationService) {
        self.service = service
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
    
    override func viewDidLayoutSubviews() {
        [surnameTextField, nameTextField,
         patronymicTextField, phoneTextField].forEach { setupBorders(for: $0) }
        
        stackView.layer.cornerRadius = 8
        continueButton.layer.cornerRadius = 12
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
    
    func setupBorders(for textfield: PaddedTextField) {
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = AppColor.gray20.cgColor
        textfield.layer.cornerRadius = 8
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
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let middleName = patronymicTextField.text ?? ""
        let deviceID = "string"
        let language = "RU"
        let currencyCode = "USD"
        let cityID = 1
        
        let user = User(name: name,
                        surname: surname,
                        middleName: middleName,
                        phone: service.getPhoneNumber(),
                        deviceID: deviceID,
                        language: language,
                        currencyCode: currencyCode,
                        cityID: cityID,
                        smsCode: service.getSMSCode())
        self.navigationController?.pushViewController(RegistrationPasswordViewController(service: self.service, user: user), animated: true)
    }
}
