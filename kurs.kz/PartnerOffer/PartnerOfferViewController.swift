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
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(AcceptedSentTableViewCell.self,
                           forCellReuseIdentifier: AcceptedSentTableViewCell.reuseID)
        tableView.register(ApplicationTableViewCell.self,
                           forCellReuseIdentifier: ApplicationTableViewCell.reuseID)
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
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateOffers()
        acceptedSendTableView.reloadData()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.navigationItem.title = "Оффер"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        
        [acceptedSendTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        acceptedSendTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Action
    @objc private func tableViewDidDrag() {
        viewModel.updateOffers()
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
        } else {
            return viewModel.getNumberOfRequests()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("trying to configure22")

        if (indexPath.section == 0 || indexPath.section == 1) {
            guard let cell =
                    tableView.dequeueReusableCell(withIdentifier: AcceptedSentTableViewCell.reuseID,
                                                  for: indexPath) as? AcceptedSentTableViewCell
            else {
                fatalError("Could not cast to AcceptedSendTableViewCell")
            }
            viewModel.configureAcceptedSentCell(with: cell, indexPath: indexPath)
            cell.backgroundColor = view.backgroundColor
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.reuseID,
                                                           for: indexPath) as? ApplicationTableViewCell else {
                fatalError("Could not cast to ApplicationTableViewCell")
            }
            viewModel.configureCell(with: cell, at: indexPath.row)
            cell.backgroundColor = view.backgroundColor

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 || indexPath.section == 1) {
            return 80.0
        } else {
            return 230
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 50 : 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 2 {
            return UIView()
        } else {
            let headerView = ApplicationsHeaderView()
            headerView.setupRequestsHeaderCounter(with: viewModel.getNumberOfRequests())
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SectionNumber.zero.rawValue {
            navigationController?.pushViewController(PartnerOfferAcceptedSentViewController(
                offers: viewModel.retrieveAcceptedOffers(),
                type: .accepted,
                service: PartnerOfferAcceptedSentService()), animated: true)
        } else if indexPath.section == SectionNumber.one.rawValue {
            navigationController?.pushViewController(PartnerOfferAcceptedSentViewController(
                offers: viewModel.retrieveSentOffers(),
                type: .sent,
                service: PartnerOfferAcceptedSentService()), animated: true)
        }
    }
}
    // MARK: - Extension PartnerOfferView
extension PartnerOfferViewController: PartnerOfferView {
    func reloadTable() {
        acceptedSendTableView.refreshControl?.endRefreshing()
        acceptedSendTableView.reloadData()
    }
}
