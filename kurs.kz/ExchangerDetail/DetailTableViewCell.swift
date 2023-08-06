//
//  CollapsibleTableViewCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: DetailTableViewCell.self)
    
    // MARK: - UI
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.medium.s14()
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Initalizers
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
        contentView.addSubview(nameLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
    }
}
