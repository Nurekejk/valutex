//
//  ProfileTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 12.07.2023.
//

import UIKit
import SnapKit

final class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: ProfileTableViewCell.self)
    
    // MARK: - UI
    private lazy var informationTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bitcoinExchange")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var informationTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои обменники"
        label.textColor = UIColor(named: "infoTypeColor")
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private let informationCellStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()
    
    // MARK: - Initializers
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
        informationCellStack.addArrangedSubview(informationTypeImageView)
        informationCellStack.addArrangedSubview(informationTypeLabel)
        contentView.addSubview(informationCellStack)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        informationCellStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        informationTypeImageView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
    }

}
