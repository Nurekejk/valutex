//
//  AccountSettingsViewController.swift
//  kurs.kz
//
//  Created by MacBook on 12.09.2023.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

final class AccountSettingsViewController: UIViewController {
    
    // MARK: - Factory
    private let factory = SkyFloatingLabelTextfieldFactory()
    
    // MARK: - Properties
    private var userAndKeys: SignInResponse?
    
    // MARK: - UI
    private var profileView = ProfileTableHeaderView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 0,
                                                                     bottom: 16,
                                                                     trailing: 0)
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var surnameTextfield: SkyFloatingLabelTextField = {
        let textfield = factory.getTextfield(with: "Фамилия")
        return textfield
    }()
    
    private lazy var nameTextfield: SkyFloatingLabelTextField = {
        let textfield = factory.getTextfield(with: "Имя")
        return textfield
    }()
    
    private lazy var patronymicTextField: SkyFloatingLabelTextField = {
        let textfield = factory.getTextfield(with: "Отчество")
        return textfield
    }()
    
    private lazy var changePasswordView: ProfileTableViewCell = {
        let view = ProfileTableViewCell()
        return view
    }()
    
    private let continueButtonContainerView: UIView = {
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
    
    private lazy var changePasswordContainerView: UIView = {
        let view = UIView()
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(changePasswordDidPress(_:)))
        gesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
        view.backgroundColor = AppColor.grayWhite.uiColor
        return view
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
        setupTextfields()
        view.backgroundColor = AppColor.gray10.uiColor
        
        changePasswordContainerView.addSubview(changePasswordView)
        continueButtonContainerView.addSubview(saveButton)
        
        [surnameTextfield, nameTextfield, patronymicTextField].forEach({stackView.addArrangedSubview($0)})
        [profileView,
         stackView,
         changePasswordContainerView,
         continueButtonContainerView].forEach({view.addSubview($0)})
        
        view.sendSubviewToBack(changePasswordContainerView)

        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        changePasswordContainerView.layer.cornerRadius = 8
        changePasswordView.profileSection = ProfileSection(image: AppImage.lockIcon.uiImage ?? UIImage(),
                                                           name: "Смена пароля")
        changePasswordView.configureCell(isBadgeHidden: true)
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Настройки аккаунта"
    }
    // MARK: - Defaults
    private func setupTextfields() {
        if let data = UserDefaults.standard.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            do {
                let response = try JSONDecoder().decode(SignInResponse.self, from: data)
                print("userInfo is \(response)")
                userAndKeys = response
                if let name = response.user?.name,
                   let surname = response.user?.surname,
                   let patronymicName = response.user?.middleName {
                    nameTextfield.text = name
                    surnameTextfield.text = surname
                    patronymicTextField.text = patronymicName
                }
            } catch {
                print("error while decoding")
            }
        } else {
            return
        }
    }
    
    // MARK: - Action
    @objc func changePasswordDidPress(_ sender: UITapGestureRecognizer) {
        self.navigationController?.pushViewController(ChangePasswordViewController(),
                                                      animated: true)
    }
    @objc func saveButtonDidPress() {
        if var userAndKeys = userAndKeys {
            userAndKeys.user?.middleName = patronymicTextField.text
            userAndKeys.user?.name = nameTextfield.text
            userAndKeys.user?.surname = surnameTextfield.text
            
            if let data = try? JSONEncoder().encode(userAndKeys) {
                print("userAndKeys is \(userAndKeys)")
                UserDefaults.standard.setValue(data, forKey: SignInViewController.defaultsUserAndTokensKey)
                profileView.getUserData()
            } else {
                print("error while encoding")
            }
        }
    }
    // MARK: - Constraints
    private func setupConstraints() {
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(148)
            make.width.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(48)
            make.height.equalTo(232)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        [surnameTextfield, nameTextfield, patronymicTextField].forEach({$0.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(16)
            make.trailing.equalTo(stackView.snp.trailing).offset(-16)
        }})
        
        changePasswordView.snp.makeConstraints { make in
            make.top.equalTo(changePasswordContainerView.snp.top)
            make.leading.equalTo(changePasswordContainerView)
            make.trailing.equalTo(changePasswordContainerView)
            make.bottom.equalTo(changePasswordContainerView.snp.bottom)
        }
        changePasswordContainerView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
        continueButtonContainerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(118)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(continueButtonContainerView.snp.top).offset(16)
            make.leading.equalTo(continueButtonContainerView.snp.leading).offset(16)
            make.trailing.equalTo(continueButtonContainerView.snp.trailing).offset(-16)
            make.height.equalTo(52)
        }
    }
}
