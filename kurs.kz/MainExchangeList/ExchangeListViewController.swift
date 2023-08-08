//
//  CurrencySelectorViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit
import SnapKit
import SkeletonView
import Pulley

// swiftlint:disable all
final class ExchangeListViewController: UIViewController {
    // MARK: - State
    public static let defaultsCurrencyKey = "savedCurrency"
    
    // MARK: Dependencies
    private let service = ExchangerListService()
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    private var searchBarText = ""
    private var exchangersArray: [Exchanger] = [] {
        didSet {
            exchangeListTableView.stopSkeletonAnimation()
            exchangeListTableView.hideSkeleton(transition: .crossDissolve(0.25))
            self.exchangeListTableView.reloadData()
        }
    }
    private var filteredArray: [Exchanger] = [] {
        didSet {
            self.exchangeListTableView.reloadData()
        }
    }
    private var isSearching = false {
        didSet {
            filtersDidChange()
        }
    }
    private var nearbySorterIsOn = false {
        didSet {
            filtersDidChange()
            if nearbySorterIsOn {
                headerView.resetSorters()
                nearbySorterButton.backgroundColor = AppColor.primarySecondary.uiColor
            } else {
                nearbySorterButton.backgroundColor = .clear
            }
        }
    }
    private var openFilterIsOn = false {
        didSet {
            filtersDidChange()
            if openFilterIsOn {
                openFilterButton.backgroundColor = AppColor.primarySecondary.uiColor
            } else {
                openFilterButton.backgroundColor = .clear
            }
        }
    }
    private var buyRateSorterState: ButtonState = .isOff {
        didSet {
            if buyRateSorterState != .isOff {
                nearbySorterIsOn = false
                filtersDidChange()
            }
        }
    }
    private var sellRateSorterState: ButtonState = .isOff {
        didSet {
            if sellRateSorterState != .isOff {
                nearbySorterIsOn = false
                filtersDidChange()
            }
        }
    }
    weak var delegate: CurrencySelectorViewControllerDelegate?
    
    // MARK: - UI
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let gripperView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 60, height: 4)
        view.backgroundColor = AppColor.gray30.uiColor
        return view
    }()
    
    private lazy var currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.setImage(AppImage.search_city.uiImage, for: .search, state: .normal)
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
        button.setImage(AppImage.calculator_button.uiImage, for: .normal)
        button.backgroundColor = AppColor.grayWhite.uiColor
        button.addTarget(self, action: #selector(calculatorButtonDidPresss), for: .touchUpInside)
        return button
    }()
    
    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.pin_button.uiImage, for: .normal)
        button.backgroundColor = AppColor.grayWhite.uiColor
        button.addTarget(self, action: #selector(selectCityDidPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.main_filter.uiImage, for: .normal)
        return button
    }()
    
    private lazy var nearbySorterButton: UIButton = {
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
        button.addTarget(self, action: #selector(openButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerView: ExchangeListHeaderView = {
        let headerView = ExchangeListHeaderView()
        headerView.сompletion = { (buyState: ButtonState, sellState: ButtonState) in
            self.buyRateSorterState = buyState
            self.sellRateSorterState = sellState
        }
        return headerView
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.map_button.uiImage, for: .normal)
        button.backgroundColor = AppColor.primarySecondary.uiColor
        button.scalesLargeContentImage = true
        button.addTarget(self, action: #selector(mapButtonDidPressed), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var exchangeListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isSkeletonable = true
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

        showSkeletonAnimation()
        getExchangers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        if self.pulleyViewController?.drawerPosition == .closed {
            self.topView.isHidden = true
            mapButton.isHidden = false
            updateConstraints()
        } else {
            self.topView.isHidden = false
            mapButton.isHidden = true
            setupConstraints()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencySearchBar.layer.borderColor = view.backgroundColor?.cgColor
        currencySearchBar.layer.borderWidth = 1
        calculatorButton.layer.borderWidth = 1
        calculatorButton.layer.borderColor = view.backgroundColor?.cgColor
        openFilterButton.layer.borderWidth = 1
        openFilterButton.layer.borderColor = AppColor.gray20.cgColor
        openFilterButton.layer.cornerRadius = 8
        nearbySorterButton.layer.borderWidth = 1
        nearbySorterButton.layer.borderColor = AppColor.gray20.cgColor
        nearbySorterButton.layer.cornerRadius = 8
        pinButton.layer.borderWidth = 1
        pinButton.layer.borderColor = view.backgroundColor?.cgColor
        mapButton.layer.cornerRadius = mapButton.frame.size.width / 2
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [topView, exchangeListTableView, mainFilterButton,
         nearbySorterButton, openFilterButton,
         currencySearchBar, calculatorButton,
         pinButton, mapButton].forEach {view.addSubview($0)}
        topView.addSubview(gripperView)
        view.backgroundColor = AppColor.gray10.uiColor
        exchangeListTableView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        let tableWidth = UIScreen.main.bounds.width - 32
        headerView.frame = CGRect(x: 0, y: 0, width: tableWidth, height: 36)
        
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        gripperView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(157.5)
            make.height.equalTo(4)
            make.width.equalTo(60)
        }
        currencySearchBar.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(calculatorButton.snp.leading)
            make.height.equalTo(48)
        }
        calculatorButton.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.trailing.equalTo(pinButton.snp.leading)
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
        pinButton.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
        nearbySorterButton.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(77)
            make.height.equalTo(34)
        }
        openFilterButton.snp.makeConstraints { make in
            make.top.equalTo(currencySearchBar.snp.bottom).offset(9)
            make.leading.equalTo(nearbySorterButton.snp.trailing).offset(8)
            make.width.equalTo(93)
            make.height.equalTo(34)
        }
        mapButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-200)
            make.size.equalTo(48)
        }
        exchangeListTableView.snp.makeConstraints { make in
            make.top.equalTo(nearbySorterButton.snp.bottom).offset(9)
            make.width.equalTo(tableWidth)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func updateConstraints() {
        currencySearchBar.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
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
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
    }
    
    // MARK: - Action
    private func showSkeletonAnimation() {
        exchangeListTableView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
    }
    
    private func getExchangers() {
        ExchangerListService().fetchExchangers(currencyCode: "USD", cityId: 1) { exchangers in
            self.exchangersArray = exchangers
            self.filteredArray = exchangers
        }
    }
    
    @objc private func calculatorButtonDidPresss() {
        self.navigationController?.pushViewController(CalculatorViewController(), animated: true)
    }
    
    @objc private func selectCityDidPress() {
        self.navigationController?.pushViewController(SelectCityViewController(), animated: true)
    }
    
    @objc private func mapButtonDidPressed() {
        self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        remove()
    }

    @objc func nearbyButtonDidPress() {
        nearbySorterIsOn = !nearbySorterIsOn
    }
    
    @objc func openButtonDidPress() {
        openFilterIsOn = !openFilterIsOn
    }
    
    private func filtersDidChange() {
        filteredArray = exchangersArray
        if isSearching {
            filteredArray = exchangersArray.filter { exchanger in
                exchanger.mainTitle.localizedCaseInsensitiveContains(searchBarText)
            }
        }
        if openFilterIsOn {
            filteredArray = filteredArray.filter({ $0.open })
        }
        if buyRateSorterState == .ascending {
            filteredArray = filteredArray.sorted(by: {$0.buyRate > $1.buyRate })
        }
        if buyRateSorterState == .descending {
            filteredArray = filteredArray.sorted(by: {$0.buyRate < $1.buyRate})
        }
        if sellRateSorterState == .ascending {
            filteredArray = filteredArray.sorted(by: {$0.sellRate > $1.sellRate })
        }
        if sellRateSorterState == .descending {
            filteredArray = filteredArray.sorted(by: {$0.sellRate < $1.sellRate})
        }
        if nearbySorterIsOn {
            filteredArray = filteredArray.sorted(by: {$0.distance ?? 0 < $1.distance ?? 0})
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
extension ExchangeListViewController: UITableViewDelegate, SkeletonTableViewDataSource, UISearchBarDelegate {
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 6
    }

    func collectionSkeletonView(_ skeletonView: UITableView,
                                cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ExchangeListTableViewCell.identifier
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        ExchangeListTableViewCell.identifier,
                                                       for: indexPath) as? ExchangeListTableViewCell else {
            fatalError("Cound not dequeue reusable cell")
        }
        cell.backgroundColor = view.backgroundColor
        if !isSearching {
            cell.changeExchanger(with: filteredArray[indexPath.row])
        } else {
            cell.changeExchanger(with: filteredArray[indexPath.row])
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
                self.isSearching = false
            }
        } else {
            isSearching = true
            searchBarText = searchText
            filtersDidChange()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let exhange = filteredArray[indexPath.row]
        let controller = DetailViewController(service: DetailPageService())
        controller.officeId = exhange.id
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - PulleyDrawerViewControllerDelegate
extension ExchangeListViewController: PulleyDrawerViewControllerDelegate {
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 154.0 + bottomSafeArea
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 379.0 + bottomSafeArea
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return [.collapsed, .partiallyRevealed, .closed, .open]
    }
}
// swiftlint:enable all
