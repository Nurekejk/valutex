//
//  OfferSendedViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 23.07.2023.
//

import UIKit
import SnapKit

final class OfferSendedViewController: UIViewController {
    
    // MARK: - UI
    private lazy var header: OfferSendedHeader = {
        let header = OfferSendedHeader()
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OfferSendedTableViewCell.self,
                           forCellReuseIdentifier: OfferSendedTableViewCell.reuseID)
        tableView.register(OfferSendedHeader.self, forHeaderFooterViewReuseIdentifier: "header_id")
        tableView.tableHeaderView = header
        tableView.rowHeight = 159
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.gray10.uiColor
        tableView.layer.cornerRadius = 8
        setupViews()
        setupConstraits()
    }
    
    // MARK: - Setup Views
    func setupViews() {
        [tableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraits
    func setupConstraits() {
        header.frame = CGRect(x: 0, y: 0, width: 343, height: 53)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(108)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(365)
        }
    }
}

// MARK: - Extension
extension OfferSendedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: OfferSendedTableViewCell.reuseID,
            for: indexPath) as? OfferSendedTableViewCell
        
        return cell ?? UITableViewCell()
    }
}
