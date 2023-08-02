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
        headerView.backgroundColor = AppColor.gray10.uiColor
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
        tableView.backgroundColor = AppColor.gray10.uiColor
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? CalculatorTableViewCell
        switch indexPath.row {
        case 0:
            let cellData = CellData(migLogoImage: UIImage(named: "exchange_logo"),
                                    titleLabel: "MИГ",
                                    starImage: UIImage(named: "golden_star"),
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
}
