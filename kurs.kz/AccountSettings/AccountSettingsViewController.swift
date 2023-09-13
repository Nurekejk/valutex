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
    
    private let factory = SkyFloatingLabelTextfieldFactory()
    
    // MARK: - UI
    private let profileView = ProfileTableHeaderView()
    
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
    
    private let containerView: UIView = {
        let container = UIView()
        return container
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
        setupConstraints()
    }
    // MARK: - Setup Views
    private func setupViews() {
        setupTextfields()
        view.backgroundColor = AppColor.gray10.uiColor
        changePasswordContainerView.addSubview(changePasswordView)
        [surnameTextfield, nameTextfield, patronymicTextField].forEach({stackView.addArrangedSubview($0)})
        [profileView, stackView, changePasswordContainerView].forEach({view.addSubview($0)})
        view.sendSubviewToBack(changePasswordContainerView)

        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        changePasswordContainerView.layer.cornerRadius = 8
        changePasswordView.profileSection = ProfileSection(image: AppImage.lockIcon.uiImage ?? UIImage(),
                                                           name: "Смена пароля")
        changePasswordView.configureCell(isBadgeHidden: true)
    }
    // MARK: - Defaults
    private func setupTextfields() {
        if let data = UserDefaults.standard.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            do {
                let response = try JSONDecoder().decode(SignInResponse.self, from: data)
                print("userInfo is \(response)")
                if let name = response.user?.name,
                   let surname = response.user?.surname {
                    nameTextfield.text = name
                    surnameTextfield.text = surname
                    patronymicTextField.text = "Отчество"
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
        print("something")
    }
    // MARK: - Constraints
    private func setupConstraints() {
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
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
    }
}
