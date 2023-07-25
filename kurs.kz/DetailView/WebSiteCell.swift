//
//  WebSiteCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 25.07.2023.
//

import UIKit
import SnapKit

final class WebSiteCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: WebSiteCell.self)
    
    // MARK: - UI
    private lazy var webSiteLabel: UILabel = {
        let label = UILabel()
        label.text = "abs.com"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = AppColor.primaryBase.uiColor
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
    private func setupViews() {
        [webSiteLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        webSiteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
    }
}
