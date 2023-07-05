//
//  OfferDetailTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 05.07.2023.
//

import UIKit

class OfferDetailsTableViewCell: UITableViewCell {
    
    // MARK: - State
     var detail: Detail? {
        didSet {
            detailTypeLabel.text = detail?.type
            detailNameLabel.text = detail?.option
        }
    }
    
    // MARK: - Outlets
    private lazy var detailTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Статус"
        label.textColor = UIColor(named: "detailTypeLabelColor")
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private lazy var detailNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Продажа"
        label.textColor = UIColor(named: "detailNameLabelColor")
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private let detailCellStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 0
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
        detailCellStack.addArrangedSubview(detailTypeLabel)
        detailCellStack.addArrangedSubview(detailNameLabel)
        contentView.addSubview(detailCellStack)
    }
    
    // MARK: -  Setup Constraints
    private func setupConstraints() {
        detailCellStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

}
