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
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Diar"
        label.font = AppFont.bold.s14()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    private let oneStarsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.golden_star.uiImage
        return imageView
    }()
    
    private let twoStarsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.golden_star.uiImage
        return imageView
    }()
    
    private let thereStarsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.golden_star.uiImage
        return imageView
    }()
    
    private let fourStarsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.golden_star.uiImage
        return imageView
    }()
    
    private let fiveStarsImageView: UIImageView = {
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
        label.textColor = AppColor.gray50.uiColor
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
        [nameLabel, oneStarsImageView, twoStarsImageView,
         thereStarsImageView, fourStarsImageView, fiveStarsImageView,
         subNameLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        oneStarsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        twoStarsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalTo(oneStarsImageView.snp.leading).offset(-4)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        thereStarsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalTo(twoStarsImageView.snp.leading).offset(-4)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        fourStarsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalTo(thereStarsImageView.snp.leading).offset(-4)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        fiveStarsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalTo(fourStarsImageView.snp.leading).offset(-4)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        subNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(fiveStarsImageView.snp.bottom).offset(34)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }
    }
}
