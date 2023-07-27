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
    
    // MARK: - UI
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: AppImage.avatar.uiImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aidos Tazhigulov"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+7(707) 303-22-00"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    private lazy var userInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
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
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        userInformationStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(94)
            make.trailing.equalToSuperview().offset(-94)
            make.height.equalTo(148)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
    }
}
