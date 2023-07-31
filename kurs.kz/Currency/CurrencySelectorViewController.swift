//
//  CurrencySelectorViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit
import PanModal
import SnapKit
import SkeletonView

final class CurrencySelectorViewController: UIViewController {
    
    // MARK: - Properties
    private var currencies: [Currency] = [] {
        didSet {
            currenciesTableView.stopSkeletonAnimation()
            currenciesTableView.hideSkeleton(transition: .crossDissolve(0.25))
            self.currenciesTableView.reloadData()
        }
    }
    
    private var filteredCurrencies = [Currency]()
    private var isSearching = false
    weak var delegate: CurrencySelectorViewControllerDelegate?
    var currencyListService = CurrencySelectorListService()
    
    // MARK: - UI
    private let sliderBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray20.uiColor
        return view
    }()
    
    private let chooseCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите валюту"
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.medium.s18()
        return label
    }()
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.cross.uiImage, for: .normal)
        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()

    private lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.addTarget(self, action: #selector(currencySelected), for: .touchUpInside)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        button.backgroundColor = AppColor.primaryBase.uiColor
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
        tableView.isSkeletonable = true
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        currencyListService.delegate = self
        currencyListService.fetchCurrencies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currenciesTableView.layer.cornerRadius = 8
        selectButton.layer.cornerRadius = 12
        sliderBorderView.layer.cornerRadius = 5
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(currenciesTableView)
        view.addSubview(chooseCurrencyLabel)
        view.addSubview(exitButton)
        view.addSubview(selectButton)
        [sliderBorderView,
         currenciesTableView,
         chooseCurrencyLabel,
         exitButton,
         selectButton].forEach {view.addSubview($0)}
        view.backgroundColor = AppColor.gray10.uiColor
        currenciesTableView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        let tableWidth = UIScreen.main.bounds.width - 32
        headerView.frame = CGRect(x: 0, y: 0, width: tableWidth, height: 52)
        
        sliderBorderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(4)
            make.width.equalTo(60)
            make.centerX.equalToSuperview()
        }
        
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
    @objc func currencySelected() {
        if let selectedIndexPath = currenciesTableView.indexPathForSelectedRow,
        let senderViewController = delegate {
            let selectedCurrency = isSearching ?
            filteredCurrencies[selectedIndexPath.row] : currencies[selectedIndexPath.row]

            senderViewController.currencyDidSelect(currency: selectedCurrency)
            dismiss(animated: true, completion: nil)
        }
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
extension CurrencySelectorViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredCurrencies.count : currencies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectorTableViewCell.identifier,
                                                    for: indexPath) as? CurrencySelectorTableViewCell {
            let tableCurrencies = isSearching ?
            filteredCurrencies[indexPath.row] : currencies[indexPath.row]
            cell.configureCell(currency: getCurrencyName(tableCurrencies,
                                                         language: selectedLanguage),
                               flagIcon: tableCurrencies.flag)
                let customSelectionView = UIView()
                customSelectionView.backgroundColor = AppColor.grayWhite.uiColor
                cell.selectedBackgroundView = customSelectionView
                return cell
            } else {
            return UITableViewCell()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
                self.isSearching = false
                self.currenciesTableView.reloadData()
            }
        } else {
            isSearching = true
            filteredCurrencies = currencies.filter { currency in
                return getCurrencyName(currency,
                                       language: selectedLanguage)
                .localizedCaseInsensitiveContains(searchText)
            }
            currenciesTableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .shortForm)
        isSearching = false
        return true
    }
}
extension CurrencySelectorViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 6
    }
    func collectionSkeletonView(_ skeletonView: UITableView,
                                cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return CurrencySelectorTableViewCell.identifier
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
        return .maxHeightWithTopInset(35)
    }
}
// MARK: - CurrencySelectorManagerDelegate
extension CurrencySelectorViewController: CurrencySelectorListServiceDelegate {
    func currencyDidUpdate(_ currency: [Currency]) {
        currencies = currency
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
// MARK: - Protocol
protocol CurrencySelectorViewControllerDelegate: AnyObject {
    func currencyDidSelect(currency: Currency)
}
