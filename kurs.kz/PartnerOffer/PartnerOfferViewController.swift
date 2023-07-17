//
//  PartnerOfferViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit
import SnapKit

final class PartnerOfferViewController: UIViewController {
    
    // MARK: - UI
    private lazy var acceptedSendTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AcceptedSendTableViewCell.self,
                           forCellReuseIdentifier: AcceptedSendTableViewCell.reuseID)
        tableView.register(ApplicationTableViewCell.self,
                           forCellReuseIdentifier: ApplicationTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        acceptedSendTableView.layer.cornerRadius = 8
        acceptedSendTableView.layer.masksToBounds = true
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        self.navigationItem.title = "Оффер"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .systemGray6
        
        [acceptedSendTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        acceptedSendTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PartnerOfferViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0 || indexPath.section == 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AcceptedSendTableViewCell.reuseID,
                                                           for: indexPath) as? AcceptedSendTableViewCell
            else {
                fatalError("Could not cast to AcceptedSendTableViewCell")
            }
            cell.selectionStyle = .none
            
            if indexPath.section == 0 {
                cell.configureCell(acceptedSendImage: "accepted-image", acceptedSendText: "Принятые (2)")
            } else if indexPath.section == 1 {
                cell.configureCell(acceptedSendImage: "sent-image", acceptedSendText: "Отправленные (1)")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.reuseID,
                                                           for: indexPath) as? ApplicationTableViewCell else {
                fatalError("Could not cast to ApplicationTableViewCell")
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 || indexPath.section == 1) {
            return 80.0
        } else {
            return 213.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 60.0 : 8.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 2 {
            return UIView()
        } else {
            let headerView = ApplicationsHeaderView()
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
