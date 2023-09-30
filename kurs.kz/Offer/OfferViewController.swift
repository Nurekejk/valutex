//
//  OfferViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 09.07.2023.
//

import UIKit

final class OfferViewController: UIViewController {
    // MARK: - Properties
    
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
        header.setupHeader(with: offer, symbol: currencySymbol ?? "?")
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OfferTableViewCell.self, forCellReuseIdentifier:
                            OfferTableViewCell.reuseIdentifier)
        tableView.register(OfferTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier:
                            OfferTableViewHeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = AppColor.gray10.uiColor
        tableView.rowHeight = 141
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
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
    
    // MARK: - Action
    private func showController() {
//        self.present(modalScreen, animated: true)
        self.presentPanModal(modalScreen)
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: OfferTableViewCell.reuseIdentifier,
            for: indexPath) as?
                OfferTableViewCell else {fatalError("message")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeader = header
        return tableHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        224
    }
}

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
