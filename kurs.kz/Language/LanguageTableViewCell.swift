//
//  LanguageTableViewCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 12.07.2023.
//

import UIKit
import SnapKit

class LanguageTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "kazakh"
        label.font = .systemFont(ofSize: 16)
        label.textColor = AppColor.darkGray.uiColor
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "selectCity")
        
        return imageView
    }()
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstraits() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
            make.leading.equalToSuperview().offset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(24)
        }
    }
    
    public func confgireCell(language: String, isSelected: Bool) {
        
        iconImageView.image = isSelected
        ? UIImage(named: "selectedCity")
        : UIImage(named: "selectCity")
        
        titleLabel.text = language
    }
}
