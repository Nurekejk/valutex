//
//  CurrencySelectorTableViewCell.swift
//  kurs.kz
//
//  Created by MacBook on 12.07.2023.
//

import UIKit
import SnapKit

class CurrencySelectorTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let identifier = "TableCell"
    
    public func configureCell(currency: String, flagIcon: String) {
        currencyLabel.text = currency
        flagLabel.text = flagIcon
    }

    // MARK: - UI
    private let flagLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "currency_unselected")
        imageView.highlightedImage = UIImage(named: "currency_selected")
        return imageView
    }()
    
    // MARK: - Initializers
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
        contentView.addSubview(flagLabel)
        contentView.addSubview(selectionImageView)
        contentView.addSubview(currencyLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        flagLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(16)
            make.width.equalTo(30)
        }
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(flagLabel.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-18)
        }
        selectionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.size.equalTo(24)
        }
    }
}
