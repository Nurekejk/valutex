//
//  ExchangeDollarTableViewCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 14.07.2023.
//

import UIKit
import SnapKit

final class ExchangeDollarTableViewCell: UITableViewCell {
    
    // MARK: - Public
    public static var reuseIdentifier = String(describing: ExchangeDollarTableViewCell.self)
    
    // MARK: - UI
    private let imageNameView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "usa")
        return imageView
    }()
    
    private lazy var nameOfTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Доллар США"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "1 доллар"
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var purchaseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "448"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var buyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "451"
        label.font = .boldSystemFont(ofSize: 16)
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
    func setupViews() {
        contentView.addSubview(imageNameView)
        contentView.addSubview(nameOfTitleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(purchaseNameLabel)
        contentView.addSubview(buyNameLabel)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        imageNameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        nameOfTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(40)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalTo(purchaseNameLabel.snp.leading).offset(-96)
        }
        
        purchaseNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-96)
            make.bottom.equalToSuperview().offset(-17)
        }
        
        buyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-17)
            
        }
    }
    
    // MARK: - Public
    public func configureCell(with imageName: String, title: String, subTitle: String) {
        imageNameView.image = UIImage(named: imageName)
        nameOfTitleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
