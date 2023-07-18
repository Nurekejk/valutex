//
//  CurrencySelectorViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit
import PanModal
import SnapKit

final class ExchangeListViewController: UIViewController {
    
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
    
    private let exchangersArray = [Exchanger(mainTitle: "Som Exchange",
                                             iconImageName: "som_exchange",
                                             rating: 4.9,
                                             totalRatings: 15,
                                             address: "г.Алматы, ул. Ауэзова 14",
                                             date: "1 марта, 2023 18:05:33",
                                             buyRate: 448,
                                             sellRate: 451,
                                             distance: "1 км"),
                                   Exchanger(mainTitle: "МИГ",
                                             iconImageName: "mig_exchange",
                                             rating: 4.9,
                                             totalRatings: 15,
                                             address: "ул. Толе би, 297 г, уг. ул. Тлендиева",
                                             date: "1 марта, 2023 18:05:33",
                                             buyRate: 448.5,
                                             sellRate: 451,
                                             distance: "1 км"),
                                   Exchanger(mainTitle: "Блиц",
                                             iconImageName: "blank_icon",
                                             rating: 4.9,
                                             totalRatings: 15,
                                             address: "ул. Толе би, 297",
                                             date: "1 марта, 2023 18:05:33",
                                             buyRate: 448,
                                             sellRate: 449.5,
                                             distance: "5 км"),
                                   Exchanger(mainTitle: "Limpopo",
                                             iconImageName: "limpopo_exchange",
                                             rating: 4.9,
                                             totalRatings: 15,
                                             address: "534, пр-т. Сейфуллина уг",
                                             date: "1 марта, 2023 18:05:33",
                                             buyRate: 448.1,
                                             sellRate: 451,
                                             distance: "3 км"),
                                   Exchanger(mainTitle: "МИГ",
                                             iconImageName: "mig_exchange",
                                             rating: 4.9,
                                             totalRatings: 15,
                                             address: "мкр. Ақбұлақ ул. Хан шатыр, 273",
                                             date: "1 марта, 2023 18:05:33",
                                             buyRate: 448.5,
                                             sellRate: 451,
                                             distance: "1 км")]
    
    private var searchArray = [Exchanger]()
    
    private var isSearching = false
    weak var delegate: CurrencySelectorViewControllerDelegate?
    
    // MARK: - UI
    
    // MARK: - Navigation Bar UI
//    private lazy var navigationCurrencySelectButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(image: UIImage(named: "search_normal"),
//                                     style: .done,
//                                     target: self,
//                                     action: #selector(selectorPressed))
//        return button
//    }()
//
    private lazy var navigationCurrencySelectButton: UIBarButtonItem = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 77, height: 24))

        let flagImageView = UIImageView(image: UIImage(named: "mig_exchange"))
        flagImageView.frame = CGRect(x: 0, y: 0, width: 18, height: 12)
        containerView.addSubview(flagImageView)

        let titleLabel = UILabel(frame: CGRect(x: 44, y: 0, width: 58, height: 24))
        titleLabel.text = "USD"
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)

        let downImageView = UIImageView(image: UIImage(named: "som_exchange"))
        downImageView.frame = CGRect(x: 102, y: 0, width: 44, height: 24)
        containerView.addSubview(downImageView)

        let button = UIBarButtonItem(customView: containerView)
        button.target = self
        button.action = #selector(selectorPressed)

        return button
    }()
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обменники"
        return label
    }()
    
    private let chooseCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите валюту"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private let currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(named: "search_normal"), for: .search, state: .normal)
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.searchTextPositionAdjustment.horizontal = CGFloat(12)
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.placeholder = "Найти обменник"
        searchBar.searchBarStyle = .default
        searchBar.barStyle = .default
        searchBar.backgroundColor = .white
        searchBar.barTintColor = UIColor.white
        
        return searchBar
    }()
    
    private lazy var calculatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "calculator_button"), for: .normal)
        button.backgroundColor = .white
        
//        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()
    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pin_button"), for: .normal)
        button.backgroundColor = .white
//        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "main_filter"), for: .normal)
//        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()
    private lazy var nearbyFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Рядом", for: .normal)
//        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()
    private lazy var openFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыто", for: .normal)
//        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()

//    private lazy var selectButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Выбрать", for: .normal)
////        button.addTarget(self, action: #selector(currencyDidSelect), for: .touchUpInside)
//        button.titleLabel?.font = .systemFont(ofSize: 16)
//        button.setTitleColor(.white, for: .normal)
//        return button
//    }()
    
    private lazy var headerView: ExchangeListHeaderView = {
        let headerView = ExchangeListHeaderView()
        return headerView
    }()
//    exchangeListTableView
    private lazy var exchangeListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.layer.masksToBounds = true
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
//        tableView.register(ExchangeListHeaderView.self,
//                           forHeaderFooterViewReuseIdentifier: ExchangeListHeaderView.identifier)
        tableView.register(ExchangeListTableViewCell.self,
                           forCellReuseIdentifier: ExchangeListTableViewCell.identifier)
        tableView.tableHeaderView = headerView
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencySearchBar.layer.borderColor = view.backgroundColor?.cgColor
        currencySearchBar.layer.borderWidth = 1
        calculatorButton.layer.borderWidth = 1
        calculatorButton.layer.borderColor = view.backgroundColor?.cgColor
        pinButton.layer.borderWidth = 1
        pinButton.layer.borderColor = view.backgroundColor?.cgColor
//        selectButton.backgroundColor = buttonBlueColor
//        selectButton.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [exchangeListTableView,
         mainFilterButton, nearbyFilterButton,
         openFilterButton, currencySearchBar,
         calculatorButton, pinButton].forEach {view.addSubview($0)}
        view.backgroundColor = backgroundGrayColor
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = navigationCurrencySelectButton
        
        self.navigationItem.titleView = navigationTitleLabel
        self.navigationItem.titleView?.backgroundColor = .cyan
        self.navigationItem.titleView?.bounds = CGRect(x: 0, y: 0, width: 258, height: 24)
        
    }

    @objc func done() { // remove @objc for Swift 3

    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        edgesForExtendedLayout = []
        
//        navigationTitleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(16)
//            make.leading.equalToSuperview().offset(16)
//            make.height.equalTo(24)
//        }
        
        let tableWidth = UIScreen.main.bounds.width - 32
        
        headerView.frame = CGRect(x: 0, y: 0, width: tableWidth, height: 36)
        
        currencySearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(calculatorButton.snp.leading)
            make.height.equalTo(48)
        }
        calculatorButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(pinButton.snp.leading)
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
        pinButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
        
//        exitButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(28)
//            make.trailing.equalToSuperview().offset(-16)
//            make.size.equalTo(24)
//        }
        exchangeListTableView.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom).offset(16)
            make.width.equalTo(tableWidth)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
//        selectButton.snp.makeConstraints { make in
//            make.top.equalTo(currenciesTableView.snp.bottom).offset(16)
//            make.leading.equalToSuperview().offset(16)
//            make.width.equalTo(343)
//            make.height.equalTo(52)
//        }
    }
    
    // MARK: - Action
    @objc func selectorPressed() {
//        if let selectedIndexPath = exchangeListTableView.indexPathForSelectedRow,
//        let senderViewController = delegate {
//            senderViewController.currencyDidSelect(selectedIndexPath:
//                                                    selectedIndexPath,
//                                                   isSearching: isSearching,
//                                                   searchArray: searchArray)
//            dismiss(animated: true, completion: nil)
//        }
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
extension ExchangeListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? searchArray.count : exchangersArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            ExchangeListTableViewCell.identifier,
                                                        for: indexPath) as? ExchangeListTableViewCell {
                cell.backgroundColor = view.backgroundColor
                
                cell.changeExchanger(with: exchangersArray[indexPath.row])
                return cell
            } else {
                return UITableViewCell()
            }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            isSearching = false
//            exchangeListTableView.reloadData()
//            searchBar.resignFirstResponder()
//        } else {
//            isSearching = true
//            searchKeyArray = currenciesKeyArray.filter { currency in
//                return currency.localizedCaseInsensitiveContains(searchText)
//            }
//            exchangeListTableView.reloadData()
//        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        isSearching = false
//        searchKeyArray.removeAll()
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
// MARK: - PanModalPresentable
// extension ExchangeListViewController: PanModalPresentable {
//
//    var panScrollable: UIScrollView? {
//        return nil
//    }
//    var shortFormHeight: PanModalHeight {
//        return .contentHeight(496)
//    }
//    var longFormHeight: PanModalHeight {
//        return .maxHeightWithTopInset(40)
//    }
// }
// MARK: - Protocol
protocol CurrencySelectorViewControllerDelegate: AnyObject {
    func currencyDidSelect(selectedIndexPath: IndexPath,
                           isSearching: Bool,
                           searchArray: [String])
}
