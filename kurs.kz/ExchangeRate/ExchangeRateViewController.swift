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
        headerView.backgroundColor = .systemGray6
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
    private lazy var safeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cохранить", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 45/255, green: 156/255, blue: 219/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    private lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = .white
        return shadowView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        title = "Курс валют"
        navigationController?.navigationBar.backItem?.title = ""
        
        view.backgroundColor = .systemGray6
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(shadowView)
        shadowView.addSubview(safeButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layer.cornerRadius = 8
    }
        
    // MARK: - Setup Constraints
    private func setupConstraints() {
        safeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        shadowView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 36)
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: 46)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
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
