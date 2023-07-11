//
//  ToSupportViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 5/7/23.
//
import UIKit
import SnapKit

final class SupportTableViewCell: UITableViewCell {
    static let identifier = "SupportTableViewCell"
    
    private let supportImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let supportLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(supportImageView)
        contentView.addSubview(supportLabel)
        
        supportImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
            make.height.width.equalTo(40)
        }
        
        supportLabel.snp.makeConstraints { make in
            make.leading.equalTo(supportImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impemented")
    }
    
    func configure(with model: (image: UIImage?, title: String)) {
        supportImageView.image = model.image
        supportLabel.text = model.title
    }
}
