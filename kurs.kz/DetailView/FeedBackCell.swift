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
    private let grayStarimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.gray_star.uiImage
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Пользовались услугами обменника? \nНапишите отзыв"
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
        [nameLabel, grayStarimageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        grayStarimageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(83)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(grayStarimageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(36)
        }
    }
}
