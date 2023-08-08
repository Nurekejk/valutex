//
//  ExchangeListTableViewCell.swift
//  kurs.kz
//
//  Created by MacBook on 16.07.2023.
//

import UIKit
import SnapKit

final class ExchangeListTableViewCell: UITableViewCell {
    // MARK: - State
    static let identifier = "ExchangeListTableCell"
    
    // MARK: - Properties
    public func changeExchanger(with newExchanger: Exchanger) {
        exchanger = newExchanger
    }
    
    private var exchanger: Exchanger? {
        didSet {
            mainTitleLabel.text = exchanger?.mainTitle
            iconImageView.image = UIImage(named: exchanger?.iconImageName ??
                                          "blank_icon")
            if let newRating = exchanger?.rating,
               let newTotalRatings = exchanger?.totalRatings {
                ratingLabel.text = "\(String(format: "%.2f", newRating))" + " (\(newTotalRatings))"
            } else {
                ratingLabel.text = "?.?"
            }
            setupAddressLabel(with: exchanger?.address ?? "",
                              and: String(format: "%.3f", exchanger?.distance ?? 1.0) + " км")
            dateLabel.text = exchanger?.formattedDate
            if let safeBuyRate = exchanger?.buyRate {
                let trimmedBuyRate = trimExchangeRate(rate: safeBuyRate)
                buyRateLabel.text = String(trimmedBuyRate)
            } else {
                buyRateLabel.text = "Ошибка"
            }
            if let safeSellRate = exchanger?.sellRate {
                let trimmedSellRate = trimExchangeRate(rate: safeSellRate)
                sellRateLabel.text = String(trimmedSellRate)
            } else {
                sellRateLabel.text = "Ошибка"
            }
        }
    }
    
    // MARK: - UI
    private let placeholderSkeletonView:UIView = {
        let view = UIView()
        view.skeletonCornerRadius = 10
        view.isSkeletonable = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.skeletonCornerRadius = 10
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.medium.s14()
        label.textColor = AppColor.gray100.uiColor
        label.skeletonTextLineHeight = .relativeToFont
        return label
    }()
    
    private let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.star12.uiImage
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray60.uiColor
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray60.uiColor
        label.linesCornerRadius = 5
        label.isSkeletonable = true
        return label
    }()
    
    private let buyRateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.bold.s16()
        label.isSkeletonable = true
        label.linesCornerRadius = 5
        return label
    }()
    
    private let sellRateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.bold.s16()
        label.isSkeletonable = true
        label.linesCornerRadius = 5
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [iconImageView, mainTitleLabel,
         ratingImageView, ratingLabel,
         addressLabel, dateLabel,
         buyRateLabel, sellRateLabel,
         placeholderSkeletonView].forEach {contentView.addSubview($0)}
        contentView.isSkeletonable = true
    }
    
    private func setupAddressLabel(with location: String, and distance: String ) {
        let locationText = location
        let distanceText = " (\(distance))"
        
        let locationTextAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.regular.s12(),
            .foregroundColor: AppColor.gray100.uiColor
        ]
        
        let distanceTextAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.semibold.s10(),
            .foregroundColor: AppColor.gray100.uiColor
        ]

        let attributedText = NSMutableAttributedString(string: locationText,
                                                       attributes: locationTextAttributes)
        let attributedDistanceString = NSAttributedString(string: distanceText,
                                                          attributes: distanceTextAttributes)
        attributedText.append(attributedDistanceString)

        addressLabel.attributedText = attributedText
    }
    private func trimExchangeRate(rate: Float) -> String {
        var trimmedResult = String(format: "%.3f", rate)
            .trimmingCharacters(in: ["0"])
        if trimmedResult.last == "." {
            trimmedResult.removeLast()
        }
        return trimmedResult
    }
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = AppColor.grayWhite.uiColor
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.frame = contentView.frame.inset(by:
                                                       UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: 4,
                                                                    right: 0))
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17.5)
            make.leading.equalToSuperview().offset(12)
            make.size.equalTo(24)
        }
        placeholderSkeletonView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(35)
            make.width.equalTo(279)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(18)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
        }
        ratingImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(mainTitleLabel.snp.trailing).offset(8)
            make.size.equalTo(12)
        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13.5)
            make.leading.equalTo(ratingImageView.snp.trailing).offset(4)
            make.height.equalTo(15)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(2)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(18)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14.5)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(buyRateLabel.snp.leading)
            make.height.equalTo(18)
        }
        buyRateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalTo(sellRateLabel.snp.leading).offset(-12)
            make.height.equalTo(20)
            make.width.equalTo(64)
        }
        sellRateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(20)
            make.width.equalTo(64)
        }
    }
}
