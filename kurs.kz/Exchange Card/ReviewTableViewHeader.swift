//
//  ReviewTableViewHeader.swift
//  kurs.kz
//
//  Created by MacBook on 27.09.2023.
//

import UIKit
import SnapKit

final class ReviewTableViewHeader: UITableViewHeaderFooterView {
    
    static let reuseID = String(describing: ReviewTableViewHeader.self)
    
    // MARK: - UI
    private let starImage: UIImageView = {
        let image = UIImageView(image: AppImage.golden_star.uiImage)
        return image
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray60.uiColor
        return label
    }()
    
    private lazy var numberOfReviewsLabel: UILabel = {
        let label = UILabel()
        label.text = "Отзывы"
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    // MARK: - Initizalizers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .white
        
        [starImage, scoreLabel, numberOfReviewsLabel].forEach {
            contentView.addSubview($0)
        }
    }
    // MARK: - Action
    public func setupHeader(score: Double?, numberOfReviews: Int?) {
        scoreLabel.text = score != nil ? "\(Double(round(10 * score!) / 10))" : ""
        numberOfReviewsLabel.text = numberOfReviews != nil ? "\(numberOfReviews!)" : ""
        contentView.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)
    }
    
    // MARK: - Setup Constraitns
    private func setupConstraints() {
        starImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(16)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(starImage.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-16)

        }
        
        numberOfReviewsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
