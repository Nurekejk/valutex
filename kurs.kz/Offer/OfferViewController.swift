//
//  OfferViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 09.07.2023.
//

import UIKit

final class OfferViewController: UIViewController {

    // MARK: - UI
    private lazy var headerView: OfferTableViewHeaderView = {
        let headerView = OfferTableViewHeaderView()
        return headerView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OfferTableViewCell.self, forCellReuseIdentifier:
                            OfferTableViewCell.reuseIdentifier)
        tableView.register(OfferTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "header_id")
        tableView.tableHeaderView = headerView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = AppColor.gray10.uiColor
        tableView.rowHeight = 141
        tableView.sectionHeaderHeight = 20
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
        view.backgroundColor = AppColor.gray10.uiColor
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        let width = UIScreen.main.bounds.width
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: 224)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension OfferViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
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
        let width = UIScreen.main.bounds.width
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        return view
    }

}
