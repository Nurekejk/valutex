//
//  PartnerOfferViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit
import SnapKit

final class PartnerOfferViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var viewModel = PartnerOfferViewModel(view: self, service: PartnerOfferService())
    
    // MARK: - UI
    private lazy var acceptedSendTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AcceptedSentTableViewCell.self,
                           forCellReuseIdentifier: AcceptedSentTableViewCell.reuseID)
        tableView.register(ApplicationTableViewCell.self,
                           forCellReuseIdentifier: ApplicationTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
//    // MARK: - Initializers
//    init(viewModel: PartnerOfferViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateOffers()
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        acceptedSendTableView.layer.cornerRadius = 8
        acceptedSendTableView.layer.masksToBounds = true
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        self.navigationItem.title = "Оффер"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .systemGray6
        
        [acceptedSendTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        acceptedSendTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PartnerOfferViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SectionNumber.zero.rawValue || section == SectionNumber.one.rawValue {
            return 1
        }
        return viewModel.getNumberOfRequests()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0 || indexPath.section == 1) {
            guard let cell =
                    tableView.dequeueReusableCell(withIdentifier: AcceptedSentTableViewCell.reuseID,
                                                  for: indexPath) as? AcceptedSentTableViewCell
            else {
                fatalError("Could not cast to AcceptedSendTableViewCell")
            }
            viewModel.configureAcceptedSentCell(with: cell, indexPath: indexPath)

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.reuseID,
                                                           for: indexPath) as? ApplicationTableViewCell else {
                fatalError("Could not cast to ApplicationTableViewCell")
            }
            viewModel.configureCell(with: cell, at: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 || indexPath.section == 1) {
            return 80.0
        } 
        return 213.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 60.0 : 8.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 2 {
            return UIView()
        } else {
            let headerView = ApplicationsHeaderView()
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SectionNumber.zero.rawValue {
            navigationController?.pushViewController(EmptyViewController(),
                                                                 animated: true)
        } else if indexPath.section == SectionNumber.one.rawValue {
            navigationController?.pushViewController(OfferSendedViewController(),
                                                                 animated: true)
        }
    }
}
    // MARK: - Extension
extension PartnerOfferViewController: PartnerOfferView {
    func reloadTable() {
        acceptedSendTableView.reloadData()
    }
    
    func updateAcceptedCount(acceptedCount: Int) {
        
    }
    
    func updateSentCount(sentCount: Int) {
        
    }
    
    func updateRequestsCount(requestsCount: Int) {
        
    }

}
