//
//  NotificationsViewController.swift
//  kurs.kz
//
//  Created by Акерке on 11.07.2023.
//

import UIKit

final class NotificationsViewController: UIViewController {
    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource  = self
        tableView.delegate = self
        return tableView
    }
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()

    }
    // MARK: - Setup Views

    private func setupViews() {

    }

    // MARK: - Setup Constraints

    private func setupConstraints() {

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
        <#code#>
    }
}


