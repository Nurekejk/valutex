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

    private var isBuying: Bool = true {
        didSet {
            if isBuying {
                headerView.makeLeftTenge()
            } else {
                headerView.makeRightTenge()
            }
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
        return headerView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(CalculatorTableViewCell.self,
                           forCellReuseIdentifier: CalculatorTableViewCell.reuseIdentifier)
        tableView.register(CalculatorTableViewHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: CalculatorTableViewHeaderView.identifier)
        tableView.rowHeight = 87
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
        getExchangers(currencyCode: "USD", cityId: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layer.cornerRadius = 8
    }

    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        tableView.backgroundColor = AppColor.gray10.uiColor
        view.addSubview(tableView)
    }
    // MARK: - Setup Navigation
    
    private func setupNavigationBar() {
        self.title = "Калькулятор"
    }
    // MARK: - Action
    
    private func getExchangers(currencyCode: String, cityId: Int) {
        CalculatorService().fetchExchangers(currencyCode: currencyCode,
                                            cityId: cityId) { fetchedExchangers in
            self.exchangers = fetchedExchangers
        }
    }
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 96)
        let tableWidth = UIScreen.main.bounds.width - 32
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(tableWidth)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
}

// MARK: - Extension

extension CalculatorViewController: CalculatorTableViewHeaderViewDelegate {
    func swapButtonDidPress(currencySwapped: Currency, at position: ButtonPosition) {
        let newPosition: ButtonPosition
        if position == .RIGHT {
            isBuying = false
            newPosition = .LEFT
            headerView.makeRightTenge()
        } else {
            isBuying = true
            newPosition = .RIGHT
            headerView.makeLeftTenge()
        }
        headerView.updateCurrency(currency: currencySwapped, position: newPosition)
        
        // city id is being hardcoded
        getExchangers(currencyCode: currencySwapped.code, cityId: 1)
        tableView.reloadData()
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
        self.isBuying = position == .RIGHT
        headerView.updateCurrency(currency: currency, position: position)
        // city id is being hardcoded
        getExchangers(currencyCode: currency.code, cityId: 1)
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        120
    }
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
