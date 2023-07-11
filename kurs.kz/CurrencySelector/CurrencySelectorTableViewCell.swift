//
//  CurrencySelectorTableViewCell.swift
//  kurs.kz
//
//  Created by MacBook on 12.07.2023.
//

import UIKit

class CurrencySelectorTableViewCell: UITableViewCell {

    // MARK: - UI
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Теперь напишите отзыв"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "currency_unselected")
        imageView.highlightedImage = UIImage(named: "currency_selected")
        return imageView
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "currency_unselected")
        imageView.highlightedImage = UIImage(named: "currency_selected")
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

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
        contentView.addSubview(selectionImageView)
        contentView.addSubview(currencyLabel)

//        detailCellStack.addArrangedSubview(detailTypeLabel)
//        detailCellStack.addArrangedSubview(detailNameLabel)
//        contentView.addSubview(detailCellStack)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
//        detailCellStack.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(16)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//        }
    }


}
