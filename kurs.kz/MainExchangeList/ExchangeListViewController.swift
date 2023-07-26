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
    private var exchangersArray: [Exchanger] = [] {
        didSet {
            self.exchangeListTableView.reloadData()
        }
    }
    private lazy var filteredArray = exchangersArray {
        didSet {
            self.exchangeListTableView.reloadData()
            print("sadasdasdasdads")
        }
    }
    private var isSearching = false {
        didSet {
//            if !isSearching {
//                filteredArray = exchangersArray
//            }
            self.exchangeListTableView.reloadData()
        }
    }
    private var nearbyFilterIsOn = true {
        didSet {
            filtersDidChange()
        }
    }
    private var openFilterIsOn = false {
        didSet {
            filtersDidChange()
        }
    }
    private var buyFilterIsOn = false {
        didSet {
            self.exchangeListTableView.reloadData()
        }
    }
    private var sellFilterIsOn = false
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
        
        let button = UIBarButtonItem(customView: containerView)
        return button
    }()
    
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Обменники"
        label.font = AppFont.medium.s18()
        return label
    }()
    
    private lazy var currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.setImage(UIImage(named: "search_normal"), for: .search, state: .normal)
        searchBar.searchTextField.font = AppFont.regular.s14()
        searchBar.searchTextPositionAdjustment.horizontal = CGFloat(12)
        searchBar.searchTextField.backgroundColor = AppColor.grayWhite.uiColor
        searchBar.placeholder = "Найти обменник"
        searchBar.searchBarStyle = .default
        searchBar.barStyle = .default
        searchBar.backgroundColor = AppColor.grayWhite.uiColor
        searchBar.barTintColor = AppColor.grayWhite.uiColor
        
        return searchBar
    }()
    
    private lazy var calculatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "calculator_button"), for: .normal)
        button.backgroundColor = AppColor.grayWhite.uiColor
        return button
    }()
    
    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pin_button"), for: .normal)
        button.backgroundColor = AppColor.grayWhite.uiColor
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
        button.setTitleColor(AppColor.gray50.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.addTarget(self, action: #selector(nearbyButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var openFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыто", for: .normal)
        button.setTitleColor(AppColor.gray50.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        return button
    }()
    
    private lazy var headerView: ExchangeListHeaderView = {
        let headerView = ExchangeListHeaderView()
        headerView.completion = {
            if $0 == 1 {
                self.buyFilterIsOn.toggle()
            } else {
                self.sellFilterIsOn.toggle()
            }
        }
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
        ExchangerListService().fetchExchangers(currencyCode: "USD", cityId: 1) { exchangers in
            self.exchangersArray = exchangers
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationCurrencySelectButton.customView?.layer.borderColor = AppColor.gray10.cgColor
        navigationCurrencySelectButton.customView?.layer.borderWidth = 1
        navigationCurrencySelectButton.customView?.layer.cornerRadius = 8
        currencySearchBar.layer.borderColor = view.backgroundColor?.cgColor
        currencySearchBar.layer.borderWidth = 1
        calculatorButton.layer.borderWidth = 1
        calculatorButton.layer.borderColor = view.backgroundColor?.cgColor
        openFilterButton.layer.borderWidth = 1
        openFilterButton.layer.borderColor = AppColor.gray20.cgColor
        openFilterButton.layer.cornerRadius = 8
        nearbyFilterButton.layer.borderWidth = 1
        nearbyFilterButton.layer.borderColor = AppColor.gray20.cgColor
        nearbyFilterButton.layer.cornerRadius = 8
        pinButton.layer.borderWidth = 1
        pinButton.layer.borderColor = view.backgroundColor?.cgColor
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [exchangeListTableView, mapButton,
         nearbyFilterButton, openFilterButton,
         currencySearchBar, calculatorButton,
         pinButton].forEach {view.addSubview($0)}
        view.backgroundColor = AppColor.gray10.uiColor
        navigationBarView.changeCurrency(newFlagImage: "🇺🇸", newCurrencyLabel: "USD")
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = navigationCurrencySelectButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:
                                                                        navigationTitleLabel)
    }
    func filtersDidChange() {
        filteredArray = exchangersArray
        if buyFilterIsOn {
            
        }
        if sellFilterIsOn {
            
        }
        if nearbyFilterIsOn {
            
            filteredArray = filteredArray.sorted(by: {$0.distance ?? 0 < $1.distance ?? 0})
            print("sadsda")
        }
        if openFilterIsOn {
            
        }
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
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
        nearbyFilterButton.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(16)
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
            make.top.equalTo(nearbyFilterButton.snp.bottom).offset(9)
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
    @objc func nearbyButtonDidPress() {
        nearbyFilterIsOn = !nearbyFilterIsOn
        print(nearbyFilterIsOn)
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
extension ExchangeListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredArray.count : exchangersArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier:
                                                            ExchangeListTableViewCell.identifier,
                                                        for: indexPath) as? ExchangeListTableViewCell {
                cell.backgroundColor = view.backgroundColor
                if !isSearching {
                    cell.changeExchanger(with: filteredArray[indexPath.row])
                } else {
                    cell.changeExchanger(with: filteredArray[indexPath.row])
                }
                return cell
            } else {
                return UITableViewCell()
            }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            searchBar.resignFirstResponder()
        } else {
            isSearching = true
            filteredArray = exchangersArray.filter { exchanger in
                exchanger.mainTitle.localizedCaseInsensitiveContains(searchText)
            }
            exchangeListTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.resignFirstResponder()
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
    
    func currencyDidSelect(currency: Currency) {
        navigationBarView.changeCurrency(newFlagImage: currency.flag,
                                         newCurrencyLabel: currency.code)
    }

 }
