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
    
    private let borderGrayColor = UIColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1)
    
    private let textGrayColor = UIColor(
        red: 147.0 / 255.0,
        green: 153.0 / 255.0,
        blue: 171.0 / 255.0,
        alpha: 1)
    
    private let currenciesDictionary = ["Доллар США" : ("usd_flag", "USD", "$"),
                                        "Евро" : ("euro_flag", "EUR", "€"),
                                        "Рос.рубль" : ("ru_flag", "RUB", "₽"),
                                        "Кирг.сом" : ("kgs_flag", "KGS", "c"),
                                        "Кит.юань" : ("cn_flag", "CNY", "¥")]
    
    private let currenciesKeyArray = ["Доллар США",
                                      "Евро",
                                      "Рос.рубль",
                                      "Кирг.сом",
                                      "Кит.юань"]
    
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
    
    private lazy var navigationBarView: NavigationBarCurencyButtonView = {
        let view = NavigationBarCurencyButtonView()
        return view
    }()
    
    private lazy var navigationCurrencySelectButton: UIBarButtonItem = {
        let buttonTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectorPressed))
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 77, height: 24))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(buttonTapGesture)
        containerView.addSubview(navigationBarView)

        navigationBarView.changeCurrency(newFlagImage: "main_usd_flag", newCurrencyLabel: "USD")
        
        let button = UIBarButtonItem(customView: containerView)
        return button
    }()
    
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обменники"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
        return button
    }()
    
    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pin_button"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var mainFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "main_filter"), for: .normal)
        return button
    }()
    
    private lazy var nearbyFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Рядом", for: .normal)
        button.setTitleColor(textGrayColor, for: .normal)
        return button
    }()
    
    private lazy var openFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыто", for: .normal)
        button.setTitleColor(textGrayColor, for: .normal)
        return button
    }()
    
    private lazy var headerView: ExchangeListHeaderView = {
        let headerView = ExchangeListHeaderView()
        return headerView
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "map_button"), for: .normal)
        button.scalesLargeContentImage = true
        return button
    }()
    
    private lazy var exchangeListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencySearchBar.layer.borderColor = view.backgroundColor?.cgColor
        currencySearchBar.layer.borderWidth = 1
        calculatorButton.layer.borderWidth = 1
        calculatorButton.layer.borderColor = view.backgroundColor?.cgColor
        openFilterButton.layer.borderWidth = 1
        openFilterButton.layer.borderColor = borderGrayColor.cgColor
        openFilterButton.layer.cornerRadius = 8
        nearbyFilterButton.layer.borderWidth = 1
        nearbyFilterButton.layer.borderColor = borderGrayColor.cgColor
        nearbyFilterButton.layer.cornerRadius = 8
        pinButton.layer.borderWidth = 1
        pinButton.layer.borderColor = view.backgroundColor?.cgColor
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [exchangeListTableView, mainFilterButton,
         nearbyFilterButton, openFilterButton,
         currencySearchBar, calculatorButton,
         pinButton, mapButton].forEach {view.addSubview($0)}
        view.backgroundColor = backgroundGrayColor
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = navigationCurrencySelectButton
        self.navigationItem.titleView?.backgroundColor = .cyan
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:
                                                                        navigationTitleLabel)
}
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        edgesForExtendedLayout = []
        
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
        mainFilterButton.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(32)
        }
        nearbyFilterButton.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom).offset(9)
            make.leading.equalTo(mainFilterButton.snp.trailing).offset(8)
            make.width.equalTo(77)
            make.height.equalTo(34)
        }
        openFilterButton.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom).offset(9)
            make.leading.equalTo(nearbyFilterButton.snp.trailing).offset(8)
            make.width.equalTo(93)
            make.height.equalTo(34)
        }
        mapButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-108)
            make.size.equalTo(48)
        }
        exchangeListTableView.snp.makeConstraints { make in
            make.top.equalTo(mainFilterButton.snp.bottom).offset(9)
            make.width.equalTo(tableWidth)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    // MARK: - Action
    @objc func selectorPressed() {
        let modalScreen = CurrencySelectorViewController()
        modalScreen.delegate = self
        self.presentPanModal(modalScreen)
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
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

    // MARK: - PanModalPresentable,CurrencySelectorViewControllerDelegate
 extension ExchangeListViewController: PanModalPresentable, CurrencySelectorViewControllerDelegate {

    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(496)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(40)
    }
     
     func currencyDidSelect(selectedIndexPath: IndexPath, isSearching: Bool, searchArray: [Currency]) {
         let currency: Currency
         if !isSearching {
             currency = currenciesKeyArray[selectedIndexPath.row]
         } else {
             currency = searchArray[selectedIndexPath.row]
         }
         navigationBarView.changeCurrency(newFlagImage: currency.flag,
                                          newCurrencyLabel: currency.)
     }
 }
