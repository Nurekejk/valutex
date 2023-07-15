//
//  ExchangerScreenViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 15/7/23.
//

import UIKit
import SnapKit

final class ExchangerScreenViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExchangerScreenTableViewCell.self,
                           forCellReuseIdentifier: ExchangerScreenTableViewCell.reuseIdentifier)
        tableView.register(ExchangerScreenTextCell.self,
                           forCellReuseIdentifier: ExchangerScreenTextCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - LifeCycle

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

extension ExchangerScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier:ExchangerScreenTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? ExchangerScreenTableViewCell
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:ExchangerScreenTextCell.reuseIdentifier,
                                                     for: indexPath) as? ExchangerScreenTextCell
            cell?.configure(with: "Ваш текст")
            return cell ?? UITableViewCell()
        }
    }
}
