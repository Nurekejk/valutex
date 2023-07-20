//
//  MyExchangesTableViewCell.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 13/7/23.
//

import UIKit
import SnapKit

final class MyExchangesTableViewCell: UITableViewCell {
    
    // MARK: - Public
    
    public static var reuseIdentifier = String(describing: MyExchangesTableViewCell.self)
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.some_exchange.uiImage
        return imageView
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.edit.uiImage, for: .normal)
        return button
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.trash.uiImage, for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Som Exchange"
        label.font = AppFont.bold.s14()
        label.textColor = AppColor.darkGray.uiColor
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "г.Алматы, ул.Aуэзова 14"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.darkGray.uiColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 8
    }
    // MARK: - Setup Views
    
    private func setupViews() {
        [titleLabel, subTitleLabel,companyImageView, editButton, deleteButton].forEach {
            containerView.addSubview($0)
        }
        
        contentView.backgroundColor = AppColor.backgroundGray.uiColor
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }
    
    // MARK: - Setup Constraints

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        companyImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(companyImageView.snp.trailing).offset(16)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(companyImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-12)
        }

        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(16)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(deleteButton.snp.leading).offset(-16)
            make.size.equalTo(16)
        }
    }
}
