//
//  NotificationsViewController.swift
//  kurs.kz
//
//  Created by Акерке on 11.07.2023.
//

import UIKit
import SnapKit

final class NotificationsViewController: UIViewController {

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(NotificationsTableViewCell.self,
                           forCellReuseIdentifier: NotificationsTableViewCell.reuseIdentifier)
        tableView.rowHeight = 126
        tableView.sectionHeaderHeight = 18
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Уведомления"
    }

    // MARK: - Setup Views
    private func setupViews() {
        tableView.backgroundColor = AppColor.gray10.uiColor
        view.backgroundColor = AppColor.gray10.uiColor
        
        view.addSubview(tableView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? NotificationsTableViewCell
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.width
        let view = NotificationsSectionHeaderView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        return view
    }
}
