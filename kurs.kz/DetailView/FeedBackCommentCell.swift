//
//  FeedBackCommentCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 25.07.2023.
//

import UIKit
import SnapKit

final class FeedBackCommentCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: FeedBackCommentCell.self)
    
    // MARK: - UI
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Diko"
        label.font = AppFont.bold.s16()
        return label
    }()
    
    private let starsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.golden_star.uiImage
        return imageView
    }()
    
    private lazy var subNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Все Отлично!"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "25.02.2023"
        label.font = AppFont.regular.s14()
        return label
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
        [nameTitleLabel, starsImageView, subNameLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        nameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        starsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalTo(nameTitleLabel.snp.trailing).offset(10)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        subNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
    }
}
