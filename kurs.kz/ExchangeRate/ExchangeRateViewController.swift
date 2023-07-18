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
        tableView.rowHeight = 56
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
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        tableView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {

        headerView.frame = CGRect(x: 0, y: 0, width: 343, height: 36)
        footerView.frame = CGRect(x: 0, y: 0, width: 343, height: 46)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(260)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeRateViewController: UITableViewDataSource, UITableViewDelegate {
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
