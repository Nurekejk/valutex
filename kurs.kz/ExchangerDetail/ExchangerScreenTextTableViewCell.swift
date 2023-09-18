//
//  ExchangerScreenTextCellTableViewCell.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 16/7/23.
//

import UIKit
import SnapKit

final class ExchangerScreenTextTableViewCell: UITableViewCell {
    
    // MARK: - Public
    static var reuseIdentifier = String(describing: ExchangerScreenTextTableViewCell.self)
    
    var name: String? {
        didSet {
            titleLabel.text = name
        }
    }
    var address: String? {
        didSet {
            subTitleLabel.text = address
        }
    }
    var score: Double? {
        didSet {
            ratingLabel.text = "\(score ?? 5)"
        }
    }
    
    // MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Som Exchange"
        label.font = AppFont.semibold.s16()
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.regular.s14(),
            .foregroundColor: AppColor.gray100.uiColor
        ]
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.bold.s14(),
            .foregroundColor: AppColor.gray100.uiColor
        ]
        let regularText = NSMutableAttributedString(string: "г.Алматы, ул.Ауэзова 14",
                                                    attributes: regularAttributes)
        let boldText = NSMutableAttributedString(string: " (1 км)", attributes: boldAttributes)
        
        regularText.append(boldText)
        label.attributedText = regularText
        label.numberOfLines = 0
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var subTitleLabelTwo: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = AppColor.statusSuccess.uiColor
        label.text = "Круглосуточно"
        label.font = AppFont.regular.s12()
        label.backgroundColor = AppColor.statusSuccess.uiColor.withAlphaComponent(0.16)
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.star_bold.uiImage
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.9"
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray60.uiColor
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 8
        subTitleLabelTwo.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [titleLabel, subTitleLabel, subTitleLabelTwo, starImageView, ratingLabel].forEach {
            containerView.addSubview($0)
        }
        contentView.backgroundColor = AppColor.gray10.uiColor
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(300)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(216)
        }
        
        subTitleLabelTwo.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        starImageView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(19)
            make.trailing.equalTo(ratingLabel.snp.leading).offset(-8)
            make.size.equalTo(16)
        }
        
        ratingLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
