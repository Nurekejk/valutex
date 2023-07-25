//
//  FeedBackCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 25.07.2023.
//

import UIKit
import SnapKit

final class FeedBackCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: FeedBackCell.self)
    
    // MARK: - UI
    private let oneGrayStarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.gray_star.uiImage
        return imageView
    }()
    
    private let twoGrayStarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.gray_star.uiImage
        return imageView
    }()
    
    private let thereGrayStarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.gray_star.uiImage
        return imageView
    }()
    
    private let fourGrayStarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.gray_star.uiImage
        return imageView
    }()
    
    private let fiveGrayStarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.gray_star.uiImage
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Пользовались услугами обменника?"
        label.font = AppFont.regular.s14()
        label.textAlignment = .center
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Напишите отзыв"
        label.font = AppFont.regular.s14()
        label.textAlignment = .center
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
        [titleLabel, oneGrayStarimageView, twoGrayStarimageView,
         thereGrayStarimageView, fourGrayStarimageView, fiveGrayStarimageView, subtitleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        oneGrayStarimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(83)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
 
        twoGrayStarimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(oneGrayStarimageView.snp.trailing).offset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        thereGrayStarimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(twoGrayStarimageView.snp.trailing).offset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        fourGrayStarimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(thereGrayStarimageView.snp.trailing).offset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        fiveGrayStarimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(fourGrayStarimageView.snp.trailing).offset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(fiveGrayStarimageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(311)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(311)
        }
    }
}
