//
//  ProfileViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 12.07.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var informationTableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.register(ProfileTableViewCell.self,
                               forCellReuseIdentifier: "cell")
            tableView.register(ProfileTableHeaderView.self,
                               forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.reuseID)
            tableView.rowHeight = 50.0
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = .orange
            tableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
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
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
