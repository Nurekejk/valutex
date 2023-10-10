//
//  PartnerOfferAcceptedViewController.swift
//  kurs.kz
//
//  Created by MacBook on 10.10.2023.
//

import UIKit
import SnapKit

final class PartnerOfferAcceptedSentViewController: UIViewController {
    
    // MARK: - Properties
    private var acceptedOffers: [AcceptedSentOfferResponse] = []
    
    private var type: PartnerOfferCellType
    // MARK: - UI
    private lazy var acceptedOffersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ApplicationsHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: ApplicationsHeaderView.reuseID)
        tableView.register(PartnerOfferAcceptedTableViewCell.self,
                           forCellReuseIdentifier: PartnerOfferAcceptedTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initializers
    init(acceptedOffers: [AcceptedSentOfferResponse], type: PartnerOfferCellType) {
        self.type = type
        self.acceptedOffers = acceptedOffers
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
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        acceptedSendTableView.layer.cornerRadius = 8
    //        acceptedSendTableView.layer.masksToBounds = true
    //    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.navigationItem.title = "Принятые"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        
        [acceptedOffersTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        acceptedOffersTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PartnerOfferAcceptedSentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        acceptedOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PartnerOfferAcceptedTableViewCell.reuseID,
            for: indexPath) as?
                PartnerOfferAcceptedTableViewCell else { fatalError("could not downcast") }
        cell.configureCell(with: acceptedOffers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ApplicationsHeaderView.reuseID) as?
                ApplicationsHeaderView else { fatalError("could not downcast") }
        header.setupHeaderCounter(with: acceptedOffers.count)
        return header
    }
}
