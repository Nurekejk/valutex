//
//  RateTableViewHeader.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 16.08.2023.
//

import UIKit
import SnapKit

final class RateTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - UI
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.star12.uiImage
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "4,9"
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray60.uiColor
        return label
    }()
    
    private lazy var feedBackLabel: UILabel = {
        let label = UILabel()
        label.text = "2 отзыва"
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.backgroundColor = .white
        
        [starImageView, feedBackLabel, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraitns
    func setupConstraints() {
        starImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(starImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        feedBackLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(18)
        }
    }
}
