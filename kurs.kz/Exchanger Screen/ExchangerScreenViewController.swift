//
//  ExchangerScreenViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 15/7/23.
//

import UIKit

class ExchangerScreenViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExchangerScreenTableViewCell.self,
                           forCellReuseIdentifier: ExchangerScreenTableViewCell.reuseIdentifier)
        tableView.rowHeight = 126
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraits()
    }
    
    // MARK: - Setup Views
    
    private func setupView() {
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

extension ExchangerScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_tableView: UITableView, cellForRowt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangerScreenTableViewCell)?.reuseIdentifier, for: IndexPath) as? ExchangerScreenTableViewCell
        return cell ?? UITableViewCell()
    }
}
