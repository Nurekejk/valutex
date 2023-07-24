//
//  CalculatorViewController.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit

final class CalculatorViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var headerView: CalculatorTableViewHeaderView = {
        let headerView = CalculatorTableViewHeaderView()
        headerView.backgroundColor = .systemGray6
        return headerView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(CalculatorTableViewCell.self,
                           forCellReuseIdentifier: CalculatorTableViewCell.reuseIdentifier)
        tableView.tableHeaderView = headerView
        tableView.rowHeight = 87
        //        tableView.sectionHeaderHeight = 18
        tableView.separatorStyle = .none
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
        tableView.backgroundColor = .systemGray6
//      view.addSubview(headerView)
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 96)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? CalculatorTableViewCell
        
        switch indexPath.row {
        case 0:
            let cellData = CellData(migLogoImage: UIImage(named: "migLogo"),
                                    titleLabel: "MИГ",
                                    starImage: UIImage(named: "star"),
                                    rateLabel: "4,9 (15)",
                                    addressLabel: "ул. Толе Би, 297 г, уг. ул. Тлендиева",
                                    kmLabel: "1 км",
                                    dateLabel: "1 октября, 2023 18:00:00",
                                    amountLabel: "1000,01")
            cell?.configureCell(data: cellData)
        default:
            break
        }
        
        return cell ?? UITableViewCell()
    }
    
    //        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //            let width = UIScreen.main.bounds.width
    //            let view = CalculatorSectionHeaderView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
    //            return view
    //        }
    
}
