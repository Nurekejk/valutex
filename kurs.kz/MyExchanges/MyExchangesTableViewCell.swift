//
//  MyExchangesTableViewCell.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 13/7/23.
//

import UIKit
import SnapKit

final class MyExchangesTableViewCell: UITableViewCell {
    
    // MARK: - Public
    
    public static var reuseIdentifier = String(describing: MyExchangesTableViewCell.self)
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Som Exchange"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var subTitleLabel: UITextField = {
        let label = UITextField()
        label.text = "г.Алматы, ул.Aуэзова 14"
        label.font = .systemFont(ofSize: 14)
        return label
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
        [titleLabel, subTitleLabel].forEach {
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
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-40)

        }
    }
}
