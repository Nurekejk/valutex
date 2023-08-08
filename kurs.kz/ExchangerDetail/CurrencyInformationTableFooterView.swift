//
//  ExchangeDollarTableViewFooterView.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 14.07.2023.
//

import UIKit
import SnapKit

final class CurrencyInformationTableFooterView: UITableViewHeaderFooterView {
    
    static let reuseID = String(describing: CurrencyInformationTableFooterView.self)
    
    // MARK: - UI
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Еще", for: .normal)
        button.setTitleColor(AppColor.primaryBase.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.medium.s14()
        return button
    }()
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8.0)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(button)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
