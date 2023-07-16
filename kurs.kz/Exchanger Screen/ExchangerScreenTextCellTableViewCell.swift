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
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "г.Алматы, ул.Ауэзова 14"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var subTitleLabelTwo: Paddinglabel = {
        let label = Paddinglabel()
        let softGreen = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.layer.borderColor = softGreen.cgColor
        label.textColor = softGreen
        label.text = "Круглосуточно"
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = UIColor.green
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.9"
        label.font = .systemFont(ofSize: 14)
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
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
           
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(-4)
            make.leading.trailing.equalTo(titleLabel)
        }
           
        subTitleLabelTwo.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8)
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
