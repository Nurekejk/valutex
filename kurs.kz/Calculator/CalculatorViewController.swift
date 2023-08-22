//
//  CalculatorViewController.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit

final class CalculatorViewController: UIViewController {

    var exchangers: [Exchanger] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var filteredArray: [Exchanger] = []

    // MARK: - State

    public static let defaultsCurrencyKey = "savedCurrency"

    // MARK: Dependencies

    private let service = CalculatorService()

    // MARK: - Properties

    private let defaults = UserDefaults.standard
    private let isSelling = true
    private var enteredValue = 0 {
        didSet {
            if enteredValue > 0 {
                
            }
        }
    }
    
    // MARK: - UI
    
    private lazy var headerView: CalculatorTableViewHeaderView = {
        let headerView = CalculatorTableViewHeaderView()
        headerView.delegate = self
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
        getExchangers()
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
    
    private func getExchangers() {
        CalculatorService().fetchExchangers(currencyCode: "USD", cityId: 1) { fetchedExchangers in
            self.exchangers = fetchedExchangers
            print(self.exchangers)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 96)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension CalculatorViewController: CalculatorTableViewHeaderViewDelegate {
    func dropDownButtonDidPressed() {
            let modalScreen = CurrencySelectorViewController()
            modalScreen.delegate = self
            self.presentPanModal(modalScreen)
        }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("stuff")
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        CalculatorTableViewCell.reuseIdentifier,
                                                       for:
                                                        indexPath) as? CalculatorTableViewCell
        else {
            fatalError("Could not dequeue reusable cell")
        }
        cell.backgroundColor = view.backgroundColor
        cell.changeExchanger(with: exchangers[indexPath.row])
        cell.calculateValue(value: enteredValue, isSelling: isSelling)
        return cell
    }
}
