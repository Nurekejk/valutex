//
//  ProfileTableHeaderView.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 13.07.2023.
//

import UIKit
import SnapKit

final class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: ProfileTableHeaderView.self)
    private let defaults = UserDefaults.standard
    
    // MARK: - UI
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: AppImage.avatar.uiImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.gray100.uiColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    private lazy var userInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        getUserData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        userInformationStackView.addArrangedSubview(avatarImageView)
        userInformationStackView.addArrangedSubview(fullNameLabel)
        userInformationStackView.addArrangedSubview(phoneNumberLabel)
        
        contentView.addSubview(userInformationStackView)
    }
    
    // MARK: - Defaults
    private func getUserData() {
        if let data = defaults.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            do {
                let response = try JSONDecoder().decode(SignInResponse.self, from: data)
                print("userInfo is \(response)")
                if let name = response.user?.name,
                   let surname = response.user?.surname,
                   let phoneNumber = response.user?.phone {
                    fullNameLabel.text = name + "" + surname
                    
                    phoneNumberLabel.text = phoneNumber
                    
                }
            } catch {
                print("error while decoding")
            }
        } else {
            return
        }
        
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        userInformationStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().offset(-90)
            make.height.equalTo(148)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
    }
}
