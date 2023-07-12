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
    private let currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(named: "search_normal"), for: .search, state: .normal)
        searchBar.setPositionAdjustment(UIOffset(horizontal: 16, vertical: 0), for: .search)
        return searchBar
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
        contentView.addSubview(currencySearchBar)
        currencySearchBar.layer.borderWidth = 1
        currencySearchBar.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        currencySearchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}

extension CurrencySelectorTableViewHeader: UISearchTextFieldDelegate {
    
}
