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
        [surnameTextfield, nameTextfield, patronymicTextField].forEach({stackView.addArrangedSubview($0)})
        [profileView, stackView].forEach({view.addSubview($0)})
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
    }
    // MARK: - Constraints
    func setupConstraints() {
        
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
    }
    
//    init(profileImage: UIImageView, phoneNumber: String) {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
