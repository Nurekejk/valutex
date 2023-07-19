//
//  OfferDetailsHeaderView.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 05.07.2023.
//

import UIKit
import SnapKit

final class OfferDetailsHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: OfferDetailsHeaderView.self)
    
    // MARK: - UI
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Детали"
        label.textColor = AppColor.darkBlue.uiColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
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
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(detailLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
}
