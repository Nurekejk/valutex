//
//  CalculatorTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit

// MARK: - Struct

struct CellData {
    let migLogoImage: UIImage?
    let titleLabel: String
    let starImage: UIImage?
    let rateLabel: String
    let addressLabel: String
    let kmLabel: String
    let dateLabel: String
    let amountLabel: String
}

final class CalculatorTableViewCell: UITableViewCell {
    
    // MARK: - Public
    
    public static var reuseIdentifier = String(describing: CalculatorTableViewCell.self)
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var migLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.exchange_logo.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MИГ"
        label.font = AppFont.bold.s14()
        return label
    }()
    private lazy var starImage: UIImageView = {
        let imageView = UIImageView(image: AppImage.golden_star.uiImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "4,9 (15)"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray60.uiColor
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "ул. Толе Би, 297 г, уг. ул. Тлендиева"
        label.font = AppFont.regular.s12()
        return label
    }()
    private lazy var kmLabel: UILabel = {
        let label = UILabel()
        label.text = "1 км"
        label.font = AppFont.regular.s10()
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1 октября, 2023 18:00:00"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray60.uiColor
        label.textAlignment = .left
        return label
    }()
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "1000,01"
        label.font = AppFont.medium.s16()
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [migLogoImage, titleLabel, starImage, rateLabel,
         addressLabel, kmLabel, dateLabel,amountLabel].forEach {
            containerView.addSubview($0)
        }
        contentView.backgroundColor = AppColor.gray10.uiColor
        containerView.backgroundColor = AppColor.grayWhite.uiColor
        contentView.addSubview(containerView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-4)
        }
        migLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17.5)
            make.leading.equalToSuperview().offset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(migLogoImage.snp.trailing).offset(16)
        }
        starImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.size.equalTo(12)
        }
        rateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13.5)
            make.leading.equalTo(starImage.snp.trailing).offset(4)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(migLogoImage.snp.trailing).offset(16)
        }
        kmLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33.5)
            make.trailing.equalToSuperview().offset(-44)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(kmLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
        }
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(kmLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    // MARK: - Public
    
    public func configureCell(data: CellData) {
        if let migLogoImage = data.migLogoImage {
            self.migLogoImage.image = migLogoImage
        }
        self.titleLabel.text = data.titleLabel
        if let starImage = data.starImage {
            self.starImage.image = starImage
        }
        self.rateLabel.text = data.rateLabel
        self.addressLabel.text = data.addressLabel
        self.kmLabel.text = data.kmLabel
        self.dateLabel.text = data.dateLabel
        self.amountLabel.text = data.amountLabel
    }
}
