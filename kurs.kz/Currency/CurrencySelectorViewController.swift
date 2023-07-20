//
//  CurrencySelectorViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit
import PanModal
import SnapKit

final class CurrencySelectorViewController: UIViewController {
    
    // MARK: - Properties
    private let buttonBlueColor = UIColor(
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1)
    
    private let backgroundGrayColor = UIColor(
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1)
    
    private var currenciesArray: [OfferSellCurrency] = [] {
        didSet {
            self.currenciesTableView.reloadData()
        }
    }
    
    private let currenciesDictionary = ["Доллар США" : "usd_flag",
                                        "Евро" : "euro_flag",
                                        "Рос.рубль" : "ru_flag",
                                        "Кирг.сом" : "kgs_flag",
                                        "Кит.юань" : "cn_flag"]
    
    private let currenciesKeyArray = ["Доллар США",
                                      "Евро",
                                      "Рос.рубль",
                                      "Кирг.сом",
                                      "Кит.юань"]
    
    private var searchKeyArray = [String]()
    private var isSearching = false
    weak var delegate: CurrencySelectorViewControllerDelegate?
    
    // MARK: - UI
    private let chooseCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите валюту"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()

    private lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.addTarget(self, action: #selector(currencyDidSelect), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var headerView: CurrencySelectorTableViewHeader = {
        let headerView = CurrencySelectorTableViewHeader()
        headerView.getSearchBar().delegate = self
        return headerView
    }()
    
    private lazy var currenciesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.register(CurrencySelectorTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CurrencySelectorTableViewHeader.identifier)
        tableView.register(CurrencySelectorTableViewCell.self,
                           forCellReuseIdentifier: CurrencySelectorTableViewCell.identifier)
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
        currenciesTableView.layer.cornerRadius = 8
        selectButton.backgroundColor = buttonBlueColor
        selectButton.layer.cornerRadius = 12

    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(currenciesTableView)
        view.addSubview(chooseCurrencyLabel)
        view.addSubview(exitButton)
        view.addSubview(selectButton)
        view.backgroundColor = backgroundGrayColor
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        let tableWidth = UIScreen.main.bounds.width - 32
        headerView.frame = CGRect(x: 0, y: 0, width: tableWidth, height: 52)
        
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
        currenciesTableView.snp.makeConstraints { make in
            make.top.equalTo(chooseCurrencyLabel.snp.bottom).offset(16)
            make.width.equalTo(tableWidth)
            make.height.equalTo(328)
            make.leading.equalToSuperview().offset(16)
        }
        selectButton.snp.makeConstraints { make in
            make.top.equalTo(currenciesTableView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(343)
            make.height.equalTo(52)
        }
    }
    
    // MARK: - Action
    @objc func closeController() {
        dismiss(animated: true, completion: nil)
    }
    @objc func currencyDidSelect() {
        if let selectedIndexPath = currenciesTableView.indexPathForSelectedRow,
        let senderViewController = delegate {
            senderViewController.currencyDidSelect(selectedIndexPath:
                                                    selectedIndexPath,
                                                   isSearching: isSearching,
                                                   searchArray: searchKeyArray)
            dismiss(animated: true, completion: nil)
        }
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
extension CurrencySelectorViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? searchKeyArray.count : currenciesKeyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectorTableViewCell.identifier,
                                                    for: indexPath) as? CurrencySelectorTableViewCell {
            let dictionaryKey = isSearching ?
            searchKeyArray[indexPath.row] : currenciesKeyArray[indexPath.row]
            if let flagName = currenciesDictionary[dictionaryKey] {
                cell.configureCell(currency: dictionaryKey, flagName: flagName)
                let customSelectionView = UIView()
                customSelectionView.backgroundColor = UIColor.white
                cell.selectedBackgroundView = customSelectionView
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            currenciesTableView.reloadData()
            searchBar.resignFirstResponder()
        } else {
            isSearching = true
            searchKeyArray = currenciesKeyArray.filter { currency in
                return currency.localizedCaseInsensitiveContains(searchText)
            }
            currenciesTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchKeyArray.removeAll()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
// MARK: - PanModalPresentable
extension CurrencySelectorViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(496)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(40)
    }
}
// MARK: - Protocol
protocol CurrencySelectorViewControllerDelegate: AnyObject {
    func currencyDidSelect(selectedIndexPath: IndexPath,
                           isSearching: Bool,
                           searchArray: [String])
}
