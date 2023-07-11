//
//  CurrencySelectorTableViewCell.swift
//  kurs.kz
//
//  Created by MacBook on 12.07.2023.
//

import UIKit
import SnapKit

class CurrencySelectorTableViewCell: UITableViewCell {

    // MARK: - UI
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "usd_flag")
        return imageView
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "parlez vous?"
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "currency_unselected")
        imageView.highlightedImage = UIImage(named: "currency_selected")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(flagImageView)
        contentView.addSubview(selectionImageView)
        contentView.addSubview(currencyLabel)
//        detailCellStack.addArrangedSubview(detailTypeLabel)
//        detailCellStack.addArrangedSubview(detailNameLabel)
//        contentView.addSubview(detailCellStack)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        flagImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(16)
            make.width.equalTo(30)
        }
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(flagImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-18)
        }
        selectionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.size.equalTo(24)
        }
    }
    public func configureCell(currency: String, flagName: String) {
        currencyLabel.text = currency
        flagImageView.image = UIImage(named: flagName)
    }
    
}
