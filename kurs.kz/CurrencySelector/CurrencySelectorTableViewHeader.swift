//
//  CurrencySelectorTableViewHeader.swift
//  kurs.kz
//
//  Created by MacBook on 12.07.2023.
//

import UIKit

final class CurrencySelectorTableViewHeader: UITableViewHeaderFooterView {
    // MARK: - UI
    static let identifier = "TableHeader"
    
    // MARK: - UI
    private let currencySearchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.ima
        return searchTextField
    }()
    
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
        contentView.addSubview(currencySearchTextField)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        currencySearchTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}

extension CurrencySelectorTableViewHeader: UISearchTextFieldDelegate {
    sea
}
