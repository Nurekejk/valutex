//
//  OfferViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 09.07.2023.
//

import UIKit

final class OfferViewController: UIViewController {
    // MARK: - Properties
    private var isRequestInProgress = false
    private var offerResponses: [OfferResponseForTableView] = [] {
        didSet {
            if !offerResponses.isEmpty {
                isRequestInProgress = false
                tableView.refreshControl?.endRefreshing()
                tableView.reloadData()
            }
        }
    }
    private let offer: Offer
    private var currencySymbol: String?
    private let service: OfferService
    
    // MARK: - UI
    private lazy var modalScreen: ChangeExchangeRateViewController = {
        let controller = ChangeExchangeRateViewController()
        controller.setExchangeRate(rate: offer.exchangeRate)
        controller.delegate = self
        return controller
    }()
    
    private lazy var header: OfferTableViewHeaderView = {
        let header = OfferTableViewHeaderView()
        header.changeButtonAction = { [weak self] in
            self?.showController()
        }
        header.cancelButtonAction = { [weak self] in
            self?.service.deleteOffer(completion: { [weak self] result in
                switch result {
                case .success:
                    print("success")
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print("error while posting review")
                }
            })
        }
        header.setupHeader(with: offer, symbol: currencySymbol ?? "?")
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OfferTableViewCell.self, forCellReuseIdentifier:
                            OfferTableViewCell.reuseIdentifier)
        tableView.register(OfferTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier:
                            OfferTableViewHeaderView.reuseIdentifier)
        tableView.register(OfferListHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: OfferListHeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl: UIRefreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: #selector(tableViewDidReload), for: .valueChanged)
        
        if #available (iOS 10.0, *) {
        tableView.refreshControl = refreshControl
        } else {
        tableView.addSubview(refreshControl)
        }
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = AppColor.gray10.uiColor
        tableView.rowHeight = 141
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        getOfferResponseList()
    }
    
    // MARK: - Initializers
    init(offer: Offer, symbol: String?, service: OfferService) {
        self.offer = offer
        print("symbol is \(symbol)")
        self.currencySymbol = symbol
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Network
    private func getOfferResponseList() {
        service.fetchOfferResponses(completion: { [weak self] result in
            switch result {
            case .success(let result):
                print("success")
                print("theerere \(result)")
                self?.offerResponses = result
            case .failure(let error):
                print("error while posting review")
            }
        })
    }
    // MARK: - Action
    private func showController() {
        self.presentPanModal(modalScreen)
    }
    
    @objc private func tableViewDidReload() {
        if isRequestInProgress {
            return
        }
        
        isRequestInProgress = true
        getOfferResponseList()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        view.addSubview(tableView)
        
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension OfferViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return offerResponses.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OfferTableViewCell.reuseIdentifier,
                for: indexPath) as?
                    OfferTableViewCell else {fatalError("message")
            }
            
            cell.delegate = self
            cell.setupCell(with: offerResponses[indexPath.row], tag: indexPath.row)
        
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let tableHeader = header
            return tableHeader
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    OfferListHeaderView.reuseIdentifier)
            return header
        default:
            return UITableViewHeaderFooterView()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 224
        } else if section == 1 {
            return 20
        } else {
            return 0
        }
    }
}
    // MARK: - ChangeExchangeRateViewControllerDelegate
extension OfferViewController: ChangeExchangeRateViewControllerDelegate {
    
    func saveChanges() {
        let updatedExchangeRate = modalScreen.getExchangeRate()
        service.updateOffer(exchangeAmount: offer.exchangeAmount,
                            exchangeRate: modalScreen.getExchangeRate()) { [weak self] result in
            switch result {
            case .success:
                self?.header.setExchangeRate(rate: updatedExchangeRate)
                print("success")
            case .failure(let error):
                print("error while posting review")
            }
        }
        
    }
}
// MARK: - OfferTableViewCellDelegate

extension OfferViewController: OfferTableViewCellDelegate {
    func acceptDidPress(offerResponseId: Int) {
        print("yay \(offerResponseId)")
    }
    
    func rejectDidPress(offerResponseId: Int) {
        print("nay \(offerResponseId)")
    }
}
