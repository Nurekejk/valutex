//
//  ExchangeRateViewController.swift
//  kurs.kz
//
//  Created by Акерке on 12.07.2023.
//

import UIKit
import SnapKit

final class ExchangeRateViewController: UIViewController {
    
    // MARK: - UI
    private lazy var headerView: ExchangeRateTableViewHeaderView = {
        let headerView = ExchangeRateTableViewHeaderView()
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(ExchangeRateTableViewCell.self,
                           forCellReuseIdentifier: ExchangeRateTableViewCell.reuseIdentifier)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
        return tableView
    }()
    private lazy var footerView: ExchangeRateTableViewFooterView = {
        let footerView = ExchangeRateTableViewFooterView()
        return footerView
    }()
    private lazy var safeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cохранить", for: .normal)
        button.tintColor = AppColor.grayWhite.uiColor
        button.backgroundColor = AppColor.primaryBase.uiColor
//        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFont.semibold.s16()
        return button
    }()
    private lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = AppColor.grayWhite.uiColor
        return shadowView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
        view.backgroundColor = .systemGray6
        [headerView, tableView, shadowView].forEach {
            view.addSubview($0)
        }
        shadowView.addSubview(safeButton)
    }
    
    // MARK: - Navigation Bar
    private func navigationBar() {
        title = "Курс валют"
    }
    
    // MARK: - ViewDid LayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layer.cornerRadius = 8
        safeButton.layer.cornerRadius = 12
    }
        
    // MARK: - Setup Constraints
    private func setupConstraints() {
        safeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        shadowView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 36)
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: 46)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(260)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ExchangeRateViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.reuseIdentifier,
            for: indexPath) as? ExchangeRateTableViewCell else {
            fatalError("Could not cast to ExchangeRateTableViewCell")
        }
        switch indexPath.row {
        case 0:
            cell.configureCell(flagImage: AppImage.KZTflag.uiImage,
                                currencyLabel: "Доллар",
                                amountOfPurchaseTextField: "500",
                                amountOfSaleTextField: "500",
                                trashButton: AppImage.trash.uiImage)
        default:
            break
        }
        return cell
    }
}
