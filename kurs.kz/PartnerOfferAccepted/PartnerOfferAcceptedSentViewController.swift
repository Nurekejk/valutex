//
//  PartnerOfferAcceptedSentViewController.swift
//  kurs.kz
//
//  Created by MacBook on 10.10.2023.
//

import UIKit
import SnapKit

final class PartnerOfferAcceptedSentViewController: UIViewController {
    
    // MARK: - Properties
    private var offers: [AcceptedSentOfferResponse] = [] {
        didSet {
            offersTableView.reloadData()
            offersTableView.refreshControl?.endRefreshing()
        }
    }
    private var type: PartnerOfferType
    
    private var service: PartnerOfferAcceptedSentService
    
    // MARK: - UI
    private lazy var offersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ApplicationsHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: ApplicationsHeaderView.reuseID)
        tableView.register(PartnerOfferAcceptedTableViewCell.self,
                           forCellReuseIdentifier: PartnerOfferAcceptedTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        let refreshControl: UIRefreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: #selector(tableViewDidDrag), for: .valueChanged)
        if #available (iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initializers
    init(offers: [AcceptedSentOfferResponse],
         type: PartnerOfferType,
         service: PartnerOfferAcceptedSentService) {
        self.type = type
        self.offers = offers
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.navigationItem.title = type == .accepted ? "Принятые" : "Отправленные"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        
        [offersTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        offersTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Action
    @objc private func tableViewDidDrag() {
        service.fetchOffers(controllerType: type) { [weak self] result in
            switch result {
            case .success(let result):
                self?.offers = result
                print("accepted is \(result)")
            case .failure:
                print("error getting accepted offers")
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PartnerOfferAcceptedSentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PartnerOfferAcceptedTableViewCell.reuseID,
            for: indexPath) as?
                PartnerOfferAcceptedTableViewCell else { fatalError("could not downcast") }
        cell.backgroundColor = view.backgroundColor
        cell.configureCell(with: offers[indexPath.row], type: type)
        
        if type == .sent {
            let item = offers[indexPath.row]
            cell.cancelButtonAction = { [weak self] in
                if let offerId = item.offerId {
                    self?.service.deleteOfferResponse(offerId: offerId,
                                                      completion: { [weak self] result in
                        switch result {
                        case .success(let result):
                            print("offer deleted successfully: \(result)")
                            self?.offers.remove(at: indexPath.row)
                            self?.offersTableView.reloadData()
                        case .failure:
                            print("error deleting the offer")
                        }
                    })
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch type {
        case .accepted:
            return 101
        case .sent:
            return 159
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ApplicationsHeaderView.reuseID) as?
                ApplicationsHeaderView else { fatalError("could not downcast") }
        switch type {
        case .accepted:
            header.setupRequestsHeaderCounter(with: offers.count)
        case .sent:
            header.setupSentHeaderCounter(with: offers.count)

        }
        return header
    }
}
