//
//  MyExchangesViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 13/7/23.
//

import UIKit

class MyExchangesViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy override var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyExchangesViewController.self,
                           forCellReuseIdentifier: MyExchangesViewController.reuseIdentifier)
        tableView.rowHeight = 126
        tableView.sectionFooterHeight = 18
        tableview.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBrown
    }
    
    //MARK: - Setup Constraints
    private func setupConstraints() {
        tableView.snp.makeConstraints() {make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MyExchangesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:MyExchangesTableViewCell.reuseIdentifier, for: IndexPath) as? MyExchangesTableViewCell
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.width
        let view = MyExchangesSectionHeaderView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        return view
    }
}

