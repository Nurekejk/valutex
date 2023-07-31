//
//  ToSupportViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 5/7/23.
//
import UIKit
import SnapKit

final class SupportTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = String(describing: SupportTableViewCell.self)
    
    // MARK: - UI
    private let supportImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let supportLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    // MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupViews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Public 
    public func configure(with model: (image: UIImage?, title: String)) {
        supportImageView.image = model.image
        supportLabel.text = model.title
    }
        
    // MARK: - SetupViews
    private func setupViews() {
        contentView.addSubview(supportImageView)
        contentView.addSubview(supportLabel)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraints() {
        supportImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(18)
            make.height.equalTo(19)
            make.width.equalTo(19)
        }
            
        supportLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(supportImageView.snp.trailing).offset(19)
        }
    }
}
