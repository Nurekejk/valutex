//
//  RateTableView.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 16.08.2023.
//

import UIKit
import SnapKit

final class RateTableView: UIViewController {
    
    // MARK: - UI
    private lazy var header: RateTableViewHeader = {
        let header = RateTableViewHeader()
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(RateCell.self, forCellReuseIdentifier: RateCell.reuseID)
        tableView.tableHeaderView = header
        tableView.dataSource = self
        tableView.rowHeight = 102
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraits()
    }
    
    // MARK: - Setup Views
    func setupViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraits
    func setupConstraits() {
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 53)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Extension
extension RateTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RateCell.reuseID,
            for: indexPath) as? RateCell
        
        return cell ?? UITableViewCell()
    }
}
