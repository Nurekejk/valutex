//
//  ExchangeDollarViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 14.07.2023.
//

import UIKit
import SnapKit

final class ExchangeDollarViewController: UIViewController {
    
    // MARK: - State
    private let nameOfImage: [String] = ["usa", "dublin", "russian"]
    
    private let nameOfTitle: [String] = ["Доллар США", "Евро", "Рубль"]
    
    private let miniTitle: [String] = ["1 доллар",  "1 евро", "1 рубль"]
    
    // MARK: - UI
    private lazy var headerView: CurrencyInformationTableHeaderView = {
        let headerView = CurrencyInformationTableHeaderView()
        return headerView
    }()
    
    private lazy var footerView: CurrencyInformationTableFooterView = {
        let footerView = CurrencyInformationTableFooterView()
        return footerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyInformationTableViewCell.self,
                           forCellReuseIdentifier: CurrencyInformationTableViewCell.reuseIdentifier)
        tableView.register(CurrencyInformationTableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "header_id")
        tableView.register(CurrencyInformationTableFooterView.self,
                           forHeaderFooterViewReuseIdentifier: "footer_id")
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.rowHeight = 56
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    func setupViews() {
        let backgroundGrayColor = UIColor(
            red: 246.0 / 255.0,
            green: 247.0 / 255.0,
            blue: 249.0 / 255.0,
            alpha: 1
        )
        
        view.backgroundColor = backgroundGrayColor
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        
        headerView.frame = CGRect(x: 0, y: 0, width: 311, height: 36)
        
        footerView.frame = CGRect(x: 0, y: 0, width: 311, height: 34)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(260)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ExchangeDollarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOfImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrencyInformationTableViewCell.reuseIdentifier,
            for: indexPath) as? CurrencyInformationTableViewCell
        
        let imageName = nameOfImage[indexPath.row]
        
        let title = nameOfTitle[indexPath.row]
        
        let subTitle = miniTitle[indexPath.row]
        
        cell?.configureCell(with: imageName, title: title, subTitle: subTitle)
        
        return cell ?? UITableViewCell()
    }
}
