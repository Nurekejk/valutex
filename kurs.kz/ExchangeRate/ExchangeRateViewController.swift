//
//  ExchangeRateViewController.swift
//  kurs.kz
//
//  Created by Акерке on 12.07.2023.
//

import UIKit
import SnapKit

final class ExchangeRateViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var headerView: ExchangeRateTableViewHeaderView = {
        let headerView = ExchangeRateTableViewHeaderView()
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(ExchangeRateTableViewCell.self,
                           forCellReuseIdentifier: ExchangeRateTableViewCell.reuseIdentifier)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.rowHeight = 32
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var footerView: ExchangeRateTableViewFooterView = {
        let footerView = ExchangeRateTableViewFooterView()
        return footerView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views

    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray6
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerView.frame = CGRect(x: 0, y: 0, width: 311, height: 36)
        footerView.frame = CGRect(x: 0, y: 0, width: 311, height: 34)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeRateViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        view.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? ExchangeRateTableViewCell
        switch indexPath.row {
        case 0:
            cell?.configureCell(flagImage: UIImage(named: "USDflag"),
                                currencyLabel: "Доллар",
                                amountOfPurchaseTextField: "500",
                                amountOfSaleTextField: "500",
                                trashButton: UIImage(named: "trashButton"))
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
}
