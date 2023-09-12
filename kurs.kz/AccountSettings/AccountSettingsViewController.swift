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
        stackView.tintColor = .cyan
        return stackView
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = AppColor.grayWhite.uiColor
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    // MARK: - Setup Views
    func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        [surnameTextfield, nameTextfield].forEach({stackView.addSubview($0)})
        [profileView, stackView].forEach({view.addSubview($0)})
    }
    // MARK: - Constraints
    func setupConstraints() {
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(94)
        }
        stackView.snp.makeConstraints { make in
//            make.top.equalTo(profileView.snp.bottom).offset(24)
            make.top.equalToSuperview().offset(24)

            make.leading.equalToSuperview().offset(16)
        }
    }
    
//    init(profileImage: UIImageView, phoneNumber: String) {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
