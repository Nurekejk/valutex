//
//  CurrencySelectorTableViewHeader.swift
//  kurs.kz
//
//  Created by MacBook on 12.07.2023.
//

import UIKit

final class CurrencySelectorTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let identifier = "TableHeader"
    
    public func getSearchBar() -> UISearchBar {
        return currencySearchBar
    }
    
    // MARK: - UI
    private let currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(named: "search_normal"), for: .search, state: .normal)
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.searchTextPositionAdjustment.horizontal = CGFloat(12)
        searchBar.barTintColor = UIColor.white
        searchBar.searchTextField.backgroundColor = UIColor.white
        
        searchBar.placeholder = "Поиск"
        return searchBar
    }()
    private let lowerBorderView: UIView = {
        let view = UIView()
        return view
    }()
    // MARK: - Initializers
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
        contentView.addSubview(lowerBorderView)
        currencySearchBar.layer.borderWidth = 1
        currencySearchBar.layer.borderColor = UIColor.white.cgColor
        lowerBorderView.backgroundColor = .systemGray6
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        currencySearchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lowerBorderView.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
