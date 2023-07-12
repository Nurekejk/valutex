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
    
    private let currenciesDictionary = ["Доллар США" : "usd_flag","Евро" : "euro_flag",
                                        "Рос.рубль" : "ru_flag", "Кирг.сом" : "kgs_flag",
                                        "Кит.юань" : "cn_flag"]
    private let currenciesKeyArray = ["Доллар США", "Евро", "Рос.рубль", "Кирг.сом",
                                      "Кит.юань"]
    private lazy var curreniesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CurrencySelectorTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 56
        
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
        //        reviewTextView.layer.cornerRadius = 8
        //        reviewTextView.layer.borderWidth = 1
        //        reviewTextView.layer.borderColor = borderGrayColor
        //        continueButton.layer.cornerRadius = 12
        //        entireStackView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(curreniesTableView)
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        curreniesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITextViewDelegate
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
