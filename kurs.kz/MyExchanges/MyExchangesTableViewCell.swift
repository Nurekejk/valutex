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
            imageView.image = UIImage(named: "some_exchange")
            return imageView
        }()
        
        private lazy var editButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "edit"), for: .normal)
            return button
        }()
        
        private lazy var deleteButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "trash"), for: .normal)
            return button
        }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Som Exchange"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var subTitleLabel: UITextField = {
        let label = UITextField()
        label.text = "г.Алматы, ул.Aуэзова 14"
        label.font = .systemFont(ofSize: 15)
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
        super
            .layoutSubviews()
        
        containerView.layer.cornerRadius = 25
    }
    // MARK: - Setup Views
    
    private func setupViews() {
        [titleLabel, subTitleLabel,companyImageView, editButton, deleteButton].forEach {
            containerView.addSubview($0)
        }
        
        let backgroundGrayColor = UIColor(
            red: 246.0 / 255.0,
            green: 247.0 / 255.0,
            blue: 249.0 / 255.0,
            alpha: 1)
        
        contentView.backgroundColor = backgroundGrayColor
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }
    
    // MARK: - Setup Constraints

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        companyImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(companyImageView)
            make.leading.equalTo(companyImageView.snp.trailing).offset(16)
            make.trailing.equalTo(editButton.snp.leading).offset(-16)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(companyImageView.snp.trailing).offset(16)
            make.trailing.equalTo(editButton.snp.leading).offset(-16)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(deleteButton.snp.leading).offset(-16)
            make.width.height.equalTo(24)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        // MARK: - Button Actions
        
    }
}
