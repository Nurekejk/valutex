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

    private var isBuying: Bool = true {
        didSet {
            if isBuying {
                headerView.makeRightTenge()
            } else {
                headerView.makeLeftTenge()
            }
//            tableView.reloadData()
        }
    }

    // MARK: - State

    public static let defaultsCurrencyKey = "savedCurrency"

    // MARK: Dependencies

    private let service = CalculatorService()

    // MARK: - Properties

    private let defaults = UserDefaults.standard

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
        getExchangers(currencyCode: "USD", cityId: 1)
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
    
    private func getExchangers(currencyCode: String, cityId: Int) {
        CalculatorService().fetchExchangers(currencyCode: currencyCode,
                                            cityId: cityId) { fetchedExchangers in
            self.exchangers = fetchedExchangers
        
            print("the exchangers are \(self.exchangers)")
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
    func swapButtonDidPress() {
        
    }
    
    func textfieldDidChange() {
        tableView.reloadData()
    }
    
    func dropDownButtonDidPressed(position: ButtonPosition) {
        let modalScreen = CurrencySelectorViewController()
        modalScreen.delegate = self
        modalScreen.position = position
        self.presentPanModal(modalScreen)
    }
}
extension CalculatorViewController: CurrencySelectorViewControllerDelegate {
    func currencyDidSelect(currency: Currency) {
        
    }

    func currencyDidSelectInCalculator(currency: Currency, position: ButtonPosition) {
        self.isBuying = position == .LEFT
        headerView.updateCurrency(currency: currency, position: position)
        // city id is being hardcoded
        getExchangers(currencyCode: currency.code, cityId: 1)
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        CalculatorTableViewCell.reuseIdentifier,
                                                       for:
                                                        indexPath) as? CalculatorTableViewCell
        else {
            fatalError("Could not dequeue reusable cell")
        }
        cell.backgroundColor = view.backgroundColor
        cell.update(with: exchangers[indexPath.row],
                    value: Float(headerView.currencyTextField.text ?? "0") ?? 1.0, isBuying: isBuying)
        return cell
    }
}
