//
//  ExchangerScreenTextCellTableViewCell.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 16/7/23.
//

import UIKit
import SnapKit

class ExchangerScreenTextCellTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public static var reuseIdentifier = String(describing: ExchangerScreenTextCellTableViewCell.self)
    
    // MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some Exchange"
        label.font = AppFont.bold.s16()
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.regular.s14(),
                .foregroundColor: UIColor.black
        ]
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFont.bold.s14(),
            .foregroundColor: UIColor.black
        ]
        let regularText = NSMutableAttributedString(string: "г.Алматы, ул.Ауэзова 14",
                                                    attributes: regularAttributes)
        let boldText = NSMutableAttributedString(string: "(1км)", attributes: boldAttributes)
        
        regularText.append(boldText)
        label.attributedText = regularText
        return label
    }()
    
    private lazy var subTitleLabelTwo: Paddinglabel = {
        let label = Paddinglabel()
        let softGreen = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        let borderColor = UIColor(red: 67/255.0, green: 160.0/255.0, blue: 72.0/255.0, alpha: 0.16)
        label.layer.borderColor = softGreen.cgColor
        label.layer.borderWidth = 1.0
        label.textColor = softGreen
        label.text = "Круглосуточно"
        label.font =  AppFont.regular.s12()
        label.backgroundColor = UIColor.green
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.star12.uiImage
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.9"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    // MARK: - Initialization
    
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
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [titleLabel, subTitleLabel, subTitleLabelTwo, starImageView, ratingLabel].forEach {
            containerView.addSubview($0)
        }
        
        let backgroundGrayColor = UIColor(
                red: 246.0 / 255.0,
                green: 247.0 / 255.0,
                blue: 249.0 / 255.0,
                alpha: 1)
        
        contentView.backgroundColor = backgroundGrayColor
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16))
            make.height.equalTo(114)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
           
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
        }
           
        subTitleLabelTwo.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(24)
            make.width.lessThanOrEqualTo(subTitleLabel.snp.width).offset(-100)
        }
        
        starImageView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-46)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        ratingLabel.snp.makeConstraints {make in
            make.centerY.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).offset(8)
        }
    }
}
