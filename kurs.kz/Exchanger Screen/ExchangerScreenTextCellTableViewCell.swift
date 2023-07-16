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
    
    // MARK: - Ui
    
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
    
    private lazy var subTitleLabel: UITextField = {
        let label = UITextField()
        label.text = "г.Алматы, ул.Ауэзова 14"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var subTitleLabelTwo: UITextField = {
        let label = UITextField()
        label.text = "Круглосуточно"
        label.font = .systemFont(ofSize: 12)
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
        [titleLabel, subTitleLabel, subTitleLabelTwo].forEach {
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
    }
}
