//
//  OfferSendedHeader.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 23.07.2023.
//

import UIKit
import SnapKit

final class OfferSendedHeader: UITableViewHeaderFooterView {
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправленные (2)"
        label.font = AppFont.bold.s16()
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.backgroundColor = AppColor.gray10.uiColor
        
        [titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraitns
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(9)
            make.height.equalTo(20)
        }
    }
}
