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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(ExchangeRateTableViewCell.self,
                           forCellReuseIdentifier: ExchangeRateTableViewCell.reuseIdentifier)
        tableView.rowHeight = 126
        tableView.sectionHeaderHeight = 18
        tableView.separatorStyle = .none
        return tableView
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
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeRateViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? ExchangeRateTableViewCell
        return cell ?? UITableViewCell()
    }
}
