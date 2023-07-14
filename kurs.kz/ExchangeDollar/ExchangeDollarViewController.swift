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
    
    private let nameOfTitle: [String] = ["Доллар США", "Евро", "Рубль"]
    
    private let miniTitle: [String] = ["1 доллар",  "1 евро", "1 рубль"]
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
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
        tableView.register(ExchangeDollarTableViewCell.self,
                           forCellReuseIdentifier: ExchangeDollarTableViewCell.reuseIdentifier)
        tableView.register(ExchangeDollarTableViewHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "header_id")
        tableView.register(ExchangeDollarTableViewFooterView.self,
                           forHeaderFooterViewReuseIdentifier: "footer_id")
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.rowHeight = 56
        
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 8
        setupViews()
        setupConstraits()
    }
    
    // MARK: - Setup Views
    
    func setupViews() {
        
        let backgroundGrayColor = UIColor(
            red: 246.0 / 255.0,
            green: 247.0 / 255.0,
            blue: 249.0 / 255.0,
            alpha: 1
        )
        
        view.backgroundColor = backgroundGrayColor
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstraits() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(96)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-496)
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: 311, height: 36)
        
        footerView.frame = CGRect(x: 0, y: 0, width: 311, height: 34)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-500)
            make.height.equalTo(232)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeDollarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOfImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeDollarTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? ExchangeDollarTableViewCell
        
        let nameOfImage = nameOfImage[indexPath.row]
        
        let nameOfTitle = nameOfTitle[indexPath.row]
        
        let miniTitle = miniTitle[indexPath.row]
        
        cell?.configureCell(nameImage: nameOfImage, nameTitle: nameOfTitle, miniTitle: miniTitle)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    }
}
