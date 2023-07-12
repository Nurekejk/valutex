//
//  CurrencySelectorTableViewHeader.swift
//  kurs.kz
//
//  Created by MacBook on 12.07.2023.
//

import UIKit

final class CurrencySelectorTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"
    
    private let currencySearchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        return searchTextField
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
//        flagImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(20)
//            make.leading.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().offset(-20)
//            make.height.equalTo(16)
//            make.width.equalTo(30)
//        }
//        currencyLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(18)
//            make.leading.equalTo(flagImageView.snp.trailing).offset(16)
//            make.bottom.equalToSuperview().offset(-18)
//        }
//        selectionImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//            make.bottom.equalToSuperview().offset(-16)
//            make.size.equalTo(24)
//        }
//    }
//    public func configureCell(currency: String, flagName: String) {
//        currencyLabel.text = currency
//        flagImageView.image = UIImage(named: flagName)
//    }
}
