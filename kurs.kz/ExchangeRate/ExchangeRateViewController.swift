//
//  ExchangeRateViewController.swift
//  kurs.kz
//
//  Created by Акерке on 12.07.2023.
//

import UIKit
import SnapKit

final class ExchangeRateViewController: UIViewController {
    
    // MARK: - Properties
    private let service: ExchangeRateService
    
    private var addedCurrencies: [CurrencyElementForExchangeRateVC] = []
    
    private var currencyList: [CurrencyElementForExchangeRateVC] = [] {
        didSet {
            tableHeight = currencyList.count * 56 + 110
            tableView.reloadData()
        }
    }
    
    private var changedCurrencies: [CurrencyElementForExchangeRateVC] = []
    
    private var deletedCurrencies: [CurrencyElementForExchangeRateVC] = []
    
    private var tableHeight = 0 {
        didSet {
            tableView.snp.updateConstraints { make in
                make.height.equalTo(tableHeight)
            }
            tableView.reloadData()
        }
    }
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(ExchangeRateTableViewHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: ExchangeRateTableViewHeaderView.reuseID)
        tableView.register(ExchangeRateTableViewFooterView.self,
                           forHeaderFooterViewReuseIdentifier: ExchangeRateTableViewFooterView.reuseID)
        tableView.register(ExchangeRateTableViewCell.self,
                           forCellReuseIdentifier: ExchangeRateTableViewCell.reuseIdentifier)
        tableView.rowHeight = 56
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cохранить", for: .normal)
        button.tintColor = AppColor.grayWhite.uiColor
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.addTarget(self, action: #selector(saveButtonDidPress), for: .touchUpInside)
//        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFont.semibold.s16()
        return button
    }()
    
    private lazy var saveButtonContainerView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = AppColor.grayWhite.uiColor
        return shadowView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrencies()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layer.cornerRadius = 8
        saveButton.layer.cornerRadius = 12
    }
    
    // MARK: - Initializers
    init(service: ExchangeRateService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
        view.backgroundColor = .systemGray6

        [tableView, saveButtonContainerView].forEach {
            view.addSubview($0)
        }
        saveButtonContainerView.addSubview(saveButton)
    }
    
    // MARK: - Navigation Bar
    private func navigationBar() {
        title = "Курс валют"
    }
    
    // MARK: - Action
    private func deleteCurrencies() {
        for currency in deletedCurrencies {
            guard let id = currency.currencyRateId else { return }
            service.deleteCurrencies(currencyId: id) { [weak self] result in
                switch result {
                case .success(let result):
                    print("deletion message: \(result)")
                case .failure:
                    print("error deliting currencies")
                }
            }
        }
    }
    
    private func updateCurrencies() {
        for currency in changedCurrencies {
            guard let id = currency.currencyRateId else { return }
            guard let sellPrice = currency.sellPrice else { return }
            guard let buyPrice = currency.buyPrice else { return }
            service.updateCurrencies(currencyId: id,
                                     buyPrice: buyPrice,
                                     sellPrice: sellPrice) { [weak self] result in
                switch result {
                case .success(let result):
                    print("update message: \(result)")
                case .failure:
                    print("error updating currencies")
                }
            }
        }
    }
    
    private func getCurrencies() {
        service.fetchCurrencyRates { [weak self] result in
            switch result {
            case .success(let result):
                self?.currencyList = result
                print("currencies are: \(result)")
            case .failure:
                print("error fetching currencies")
            }
        }
    }
    
    private func addCurrencies() {
        for currency in addedCurrencies {
            service.createCurrencyRate(newCurrencyRate: currency) { [weak self] result in
                switch result {
                case .success(let result):
                    print("create message: \(result)")
                case .failure:
                    print("error creating currency")
                }
            }
        }
    }
    
    @objc private func saveButtonDidPress() {
        deleteCurrencies()
        updateCurrencies()
        addCurrencies()
        print("the size is \(tableView.visibleCells)")
        print("the size is \(tableView.visibleCells.first?.bounds.height)")

    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        saveButtonContainerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(112)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(tableHeight)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ExchangeRateViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ExchangeRateTableViewHeaderView.reuseID) as? ExchangeRateTableViewHeaderView
        else { return UITableViewHeaderFooterView() }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ExchangeRateTableViewFooterView.reuseID) as? ExchangeRateTableViewFooterView
        else { return UITableViewHeaderFooterView() }
        footer.addCurrencyButtonAction = {
            let addCurrencyController = AddCurrencyViewController(existingCurrencies: self.currencyList)
            addCurrencyController.delegate = self
            self.navigationController?
                .pushViewController(addCurrencyController, animated: true)
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.reuseIdentifier,
            for: indexPath) as? ExchangeRateTableViewCell else {
            fatalError("Could not cast to ExchangeRateTableViewCell")
        }
        let currency = currencyList[indexPath.row]
        cell.configureCell(currency: currency, index: indexPath.row)
        cell.deleteAction = { [weak self] in
            guard let self = self else { return }
            let deletedCurrency = currencyList.remove(at: indexPath.row)
            addedCurrencies.removeAll { currency in
                return currency.currencyCode == deletedCurrency.currencyCode
            }
            deletedCurrencies.append(deletedCurrency)
        }
        cell.updateAction = { [weak self] updatedCurrency in
            guard let self = self else { return }
            if let index = addedCurrencies.firstIndex(
                where: { $0.currencyCode == updatedCurrency.currencyCode }) {
                addedCurrencies[index] = updatedCurrency
            } else {
                changedCurrencies.removeAll { currency in
                    return currency.currencyCode == updatedCurrency.currencyCode
                }
                changedCurrencies.append(updatedCurrency)
                print(changedCurrencies)
            }
        }
        return cell
    }
}
    // MARK: - AddCurrencyViewControllerDelegate
extension ExchangeRateViewController: AddCurrencyViewControllerDelegate {
    func currencyDidAdd(currency: CurrencyElementForExchangeRateVC) {
        addedCurrencies.append(currency)
        currencyList.append(currency)
    }
}
