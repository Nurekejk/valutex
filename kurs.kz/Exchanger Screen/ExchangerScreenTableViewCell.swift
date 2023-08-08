//
//  ExchangerScreenTableViewCell.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 15/7/23.
//

import UIKit
import SnapKit

final class ExchangerScreenTableViewCell: UITableViewCell {
    
    // MARK: - Public
    static var reuseIdentifier = String(describing: ExchangerScreenTableViewCell.self)
    
    // MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = AppImage.exchanger_screen.uiImage
        return imageView
    }()
    
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 8
        
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [cellImageView, buttonImageView].forEach {
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
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 16, bottom: 8, right: 16))
            make.width.equalTo(343)
            make.height.equalTo(117)
           }
        
        cellImageView.snp.makeConstraints {make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(containerView.snp.height).multipliedBy(1.05)
        }
        buttonImageView.snp.makeConstraints {make in
            make.bottom.trailing.equalTo(cellImageView).offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
}
