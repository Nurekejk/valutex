//
//  FeedbackTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 04.08.2023.
//

import UIKit

final class FeedbackTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: FeedbackTableViewCell.self)
    
    // MARK: - UI
    public let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.user_tag.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = AppColor.gray100.uiColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Отзывы (2)"
        titleLabel.font = AppFont.regular.s14()
        return titleLabel
    }()
    
    public lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.arrow_right.uiImage
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initalizers
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
        contentView.backgroundColor = .white
        
        [iconImageView, titleLabel, arrowImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(18)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(16)
        }
    }
}
