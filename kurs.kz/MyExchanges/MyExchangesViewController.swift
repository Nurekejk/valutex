//
//  MyExchangesViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 13/7/23.
//

import UIKit
import SnapKit

final class MyExchangesViewController: UIViewController {
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyExchangesTableViewCell.self,
                           forCellReuseIdentifier: MyExchangesTableViewCell.reuseIdentifier)
        tableView.rowHeight = 71
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Мои обменники"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = AppColor.gray10.uiColor
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        tableView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MyExchangesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyExchangesTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? MyExchangesTableViewCell
        else { return UITableViewCell() }
        return cell
    }
}
