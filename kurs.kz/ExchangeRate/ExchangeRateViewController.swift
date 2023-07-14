//
//  ExchangeRateViewController.swift
//  kurs.kz
//
//  Created by Акерке on 12.07.2023.
//

import UIKit
import SnapKit

final class ExchangeRateViewController: UIViewController {

    // MARK: - State

    // 1 trying
    //    let image: [UIImage] = [
    //        UIImage(named: "USDflag").flatMap { $0 },
    //        UIImage(named: "EUROflag").flatMap { $0 },
    //        UIImage(named: "RUflag").flatMap { $0 }
    //    ].compactMap { $0 }

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(ExchangeRateTableViewCell.self,
                           forCellReuseIdentifier: ExchangeRateTableViewCell.reuseIdentifier)
        tableView.rowHeight = 80
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
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray6
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeRateViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView() // Create an empty view as a placeholder for the spacing
    }
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        view.backgroundColor = .clear
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? ExchangeRateTableViewCell
        switch indexPath.row {
        case 0:
            cell!.flagImage.image = UIImage(named: "USDflag")
            cell!.currencyLabel.text = "Доллар"
            cell!.amountOfPurchaseTextField.placeholder = "500"
            cell!.amountOfSaleTextField.placeholder = "500"
            cell!.trashButton.setImage(UIImage(named: "trash"), for: .normal)

        case 1:
            cell!.flagImage.image = UIImage(named: "EUROflag")
            cell!.currencyLabel.text = "Евро"
            cell!.amountOfPurchaseTextField.placeholder = "500"
            cell!.amountOfSaleTextField.placeholder = "500"
            cell!.trashButton.setImage(UIImage(named: "trash"), for: .normal)

        case 2:
            cell!.flagImage.image = UIImage(named: "RUflag")
            cell!.currencyLabel.text = "Рубль"
            cell!.amountOfPurchaseTextField.placeholder = "500"
            cell!.amountOfSaleTextField.placeholder = "500"
            cell!.trashButton.setImage(UIImage(named: "trash"), for: .normal)

        default:
            break
        }
        // 2 trying
        //        let image = self.image[indexPath.row]
        //        cell!.configure(with: image, and: indexPath.row.description)

        return cell ?? UITableViewCell()
    }
}
