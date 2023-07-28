//
//  OfferSendedTableViewCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 23.07.2023.
//

import UIKit
import SnapKit

final class OfferSendedTableViewCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: OfferSendedTableViewCell.self)
    
    // MARK: - UI
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aidos Tazhigulov"
        label.font = AppFont.bold.s14()
        return label
    }()
    
    private let ministarsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ministars")
        return imageView
    }()
    
    private lazy var feedBackLabel: UILabel = {
        let label = UILabel()
        label.text = "4 (10)"
        label.font = AppFont.regular.s12()
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "+7(707) 303-22-00"
        label.font = AppFont.regular.s12()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Покупает: 250 500 ₸  по курсу: 500$"
        label.font = AppFont.regular.s16()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = AppColor.gray10.uiColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [nameLabel, ministarsImageView, feedBackLabel, subTitleLabel, priceLabel, cancelButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        ministarsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalTo(nameLabel.snp.trailing).offset(4)
            make.height.equalTo(12)
            make.width.equalTo(12)
        }
        
        feedBackLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalTo(nameLabel.snp.trailing).offset(20)
            make.height.equalTo(15)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
            make.width.equalTo(311)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(42)
            make.width.equalTo(311)
        }
    }
}
