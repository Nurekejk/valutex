//
//  PartnerOfferViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit

class PartnerOfferViewController: UIViewController {

    // MARK: - UI
    private lazy var acceptedSendTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AcceptedSendTableViewCell.self,
                           forCellReuseIdentifier: AcceptedSendTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80.0
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AcceptedSendTableViewCell.reuseID,
                                                       for: indexPath) as? AcceptedSendTableViewCell else {
            fatalError("Could not cast to AcceptedSendTableViewCell")
        }
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            cell.configureCell(acceptedSendImage: "accepted-image", acceptedSendText: "Принятые (2)")
        } else if indexPath.section == 1 {
            cell.configureCell(acceptedSendImage: "sent-image", acceptedSendText: "Отправленные (1)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return UIView()
        }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }
}
