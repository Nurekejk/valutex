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
                ratingLabel.text = "\(newRating)" + " (\(newTotalRatings))"
            } else {
                ratingLabel.text = "?.?"
            }
            setupAddressLabel(with: exchanger?.address ?? "",
                              and: exchanger?.distance ?? "")
            dateLabel.text = exchanger?.date
            if let newBuyRate = exchanger?.buyRate {
                buyRateLabel.text = String(newBuyRate)
            } else {
                buyRateLabel.text = "ОшибкаОшибка"
            }
            if let newSellRate = exchanger?.sellRate {
                sellRateLabel.text = String(newSellRate)
            } else {
                sellRateLabel.text = "Ошибка"
            }
        }
    }
    
    // MARK: - UI
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font =  AppFont.medium.s14()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    private let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rating_icon")
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font =  AppFont.regular.s12()
        label.textColor = AppColor.gray60.uiColor
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setupAddressLabel(with location: String, and distance: String ) {
        let locationText = location
        let distanceText = distance
        
        let locationTextAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.regular.s12(),
            .foregroundColor: AppColor.gray100.uiColor
        ]
        
        let distanceTextAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.bold.s12(),
            .foregroundColor: AppColor.gray60.uiColor
        ]

        let attributedText = NSMutableAttributedString(string: locationText, attributes: locationTextAttributes)
        let attributedDistanceString = NSAttributedString(string: distanceText,
                                                          attributes: distanceTextAttributes)
        attributedText.append(attributedDistanceString)

        addressLabel.attributedText = attributedText
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let buyRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let sellRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
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
         buyRateLabel, sellRateLabel].forEach {contentView.addSubview($0)}
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
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
            make.height.equalTo(18)
        }
        sellRateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalTo(buyRateLabel.snp.leading).offset(-12)
            make.height.equalTo(20)
            make.width.equalTo(64)
        }
        buyRateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(20)
            make.width.equalTo(64)
        }
    }
}
