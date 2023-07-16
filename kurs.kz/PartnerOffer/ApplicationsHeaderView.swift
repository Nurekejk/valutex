//
//  ApplicationsHeaderView.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit
import SnapKit

final class ApplicationsHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: ApplicationsHeaderView.self)
    
    // MARK: - UI
    let applicationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявки (2)"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
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
        contentView.addSubview(applicationsLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        applicationsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
