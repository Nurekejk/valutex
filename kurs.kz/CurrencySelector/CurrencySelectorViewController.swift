//
//  CurrencySelectorViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit
import SnapKit

final class CurrencySelectorViewController: UIViewController {
    
    private let buttonBlueColor = UIColor(
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1)
    
    private let borderGrayColor = CGColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1)
    
    private let backgroundGrayColor = UIColor(
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1)
    
    // MARK: - UI
    private let chooseCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите валюту"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cross"), for: .normal)
        return button
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let currenciesDictionary = ["Доллар США" : "usd_flag", "Евро" : "euro_flag",
                                        "Рос.рубль" : "ru_flag", "Кирг.сом" : "kgs_flag",
                                        "Кит.юань" : "cn_flag"]
    private let currenciesKeyArray = ["Доллар США", "Евро", "Рос.рубль", "Кирг.сом",
                                      "Кит.юань"]
    
    private lazy var headerView: CurrencySelectorTableViewHeader = {
        let headerView = CurrencySelectorTableViewHeader()
        return headerView
    }()
    
    private lazy var curreniesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CurrencySelectorTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CurrencySelectorTableViewHeader.identifier)
        tableView.register(CurrencySelectorTableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.rowHeight = 56
        tableView.tableHeaderView = headerView
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        curreniesTableView.layer.cornerRadius = 8
        curreniesTableView.layer.backgroundColor = buttonBlueColor.cgColor
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(curreniesTableView)
        view.addSubview(chooseCurrencyLabel)
        view.addSubview(exitButton)
        view.backgroundColor = backgroundGrayColor

    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        chooseCurrencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(24)
        }
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(24)
        }
        curreniesTableView.snp.makeConstraints { make in
            make.top.equalTo(chooseCurrencyLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(276)

        }
        
        headerView.frame = CGRect(x: 100, y: 100, width: 100, height: 52)
        
    }
}

// MARK: - UITableViewDelegate
extension CurrencySelectorViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currenciesKeyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as? CurrencySelectorTableViewCell
        let dictionaryKey = currenciesKeyArray[indexPath.row]
        if let flagName = currenciesDictionary[dictionaryKey] {
            cell?.configureCell(currency: currenciesKeyArray[indexPath.row], flagName: flagName)
            let customSelectionView = UIView()
            customSelectionView.backgroundColor = UIColor.white
            cell?.selectedBackgroundView = customSelectionView
            return cell ?? UITableViewCell()
        } else {
            return UITableViewCell()
        }
    }
    
}
