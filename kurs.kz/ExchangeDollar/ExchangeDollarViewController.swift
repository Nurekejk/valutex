//
//  ExchangeDollarViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 14.07.2023.
//

import UIKit
import SnapKit

final class ExchangeDollarViewController: UIViewController {
    
    // MARK: - State
    
    private let nameOfImage: [String] = ["usa", "dublin", "russian"]
    
    private let nameOfTitle: [String] = ["Доллар", "Евро", "Рубль"]
    
    private let miniTitle: [String] = ["1 доллар",  "1 евро", "1 рубль"]
    
    
    // MARK: - UI
    
    private lazy var headerView: ExchangeDollarTableViewHeaderView = {
        let headerView = ExchangeDollarTableViewHeaderView()
        
        return headerView
    }()
    
    private lazy var footerView: ExchangeDollarTableViewFooterView = {
        let footerView = ExchangeDollarTableViewFooterView()
        
        return footerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "newcell")
        tableView.register(ExchangeDollarTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "header_id")
        tableView.register(ExchangeDollarTableViewFooterView.self, forHeaderFooterViewReuseIdentifier: "footer_id")
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.rowHeight = 56
        
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
        
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstraits() {
        
        headerView.frame = CGRect(x: 0, y: 0, width: 311, height: 36)
        
        footerView.frame = CGRect(x: 0, y: 0, width: 311, height: 34)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(72)
            make.bottom.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeDollarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOfImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newcell",
                                                 for: indexPath) as? ExchangeDollarTableViewCell
        
        let nameOfImage = nameOfImage[indexPath.row]
        
        let nameOfTitle = nameOfTitle[indexPath.row]
        
        let miniTitle = miniTitle[indexPath.row]
        
        cell?.configureCell(nameImage: nameOfImage, nameTitle: nameOfTitle, miniTitle: miniTitle)
        
        return cell ?? UITableViewCell()
    }
}
