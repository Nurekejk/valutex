//
//  ApplicationTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit

final class ApplicationTableViewCell: UITableViewCell {
    // MARK: - State
    static let reuseID = String(describing: ApplicationTableViewCell.self)
    
    // MARK: - UI
    private lazy var partnerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aidos Tazhigulov"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yellow-star")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4 (10)"
        label.textColor = UIColor(named: "partnerOfferGrayTextColor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var partnerNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
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
        contentView.addSubview(partnerNameStackView)
        
        [partnerNameLabel, starImageView, ratingLabel].forEach {
            partnerNameStackView.addArrangedSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        partnerNameStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
            make.width.equalTo(113)
        }
    }
}
