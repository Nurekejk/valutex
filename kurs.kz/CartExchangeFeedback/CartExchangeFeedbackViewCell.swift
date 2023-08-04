//
//  CartExchangeFeedbackViewCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 13.07.2023.
//

import UIKit
import SnapKit

final class CartExchangeFeedbackViewCell: UITableViewCell {
    
    // MARK: - Public
    static var reuseID = String(describing: CartExchangeFeedbackViewCell.self)
    
    // MARK: - UI
    private let iconImageView: UIImageView = {
        let iconImage = UIImageView()
        iconImage.contentMode = .scaleToFill
        iconImage.image = AppImage.sms.uiImage
        return iconImage
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "kazakh"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let secondIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = AppImage.arrowDown.uiImage
        return imageView
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(secondIconImageView)
    }
    
    // MARK: - Setup Constraits
    func setupConstraits() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalToSuperview().offset(56)
            make.trailing.equalToSuperview().offset(-48)
        }
        
        secondIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.trailing.equalToSuperview().offset(-16)
            
        }
    }
    
    public func configureCell(language: String, titleOfIcon: String) {
        titleLabel.text = language
        iconImageView.image = UIImage(named: titleOfIcon)
    }
}
