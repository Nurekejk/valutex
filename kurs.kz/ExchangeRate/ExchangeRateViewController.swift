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
    
    private var currencyList: [CurrencyElementForExchangeRateVC] = [] {
        didSet {
            tableHeight = currencyList.count * 70 + 68
        }
    }
    
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
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var footerView: ExchangeRateTableViewFooterView = {
        let footerView = ExchangeRateTableViewFooterView()
        return footerView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cохранить", for: .normal)
        button.tintColor = AppColor.grayWhite.uiColor
        button.backgroundColor = AppColor.primaryBase.uiColor
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
        cell.configureCell(flagImage: currency.currencyFlag ?? "",
                           currencyLabel: currency.currencyRuName ?? "",
                           buyRate: currency.buyPrice,
                           sellRate: currency.sellPrice)
        return cell
    }
}
