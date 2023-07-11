//
//  NotificationsViewController.swift
//  kurs.kz
//
//  Created by Акерке on 11.07.2023.
//

import UIKit
import SnapKit

final class NotificationsViewController: UIViewController {

    // MARK: - State
        private var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0) {
            didSet {
                tableView.reloadData()
            }
        }

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(NotificationsTableViewCell.self, forCellReuseIdentifier: "notifications_cell")
        tableView.rowHeight = 126
        return tableView
    }()
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()

    }
    // MARK: - Setup Views

    private func setupViews() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifications_cell",
                                                 for: indexPath) as? NotificationsTableViewCell
        return cell ?? UITableViewCell()
    }
}
