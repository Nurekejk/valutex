//
//  OfferViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 09.07.2023.
//

import UIKit

final class OfferViewController: UIViewController {

    // MARK: - Outlets

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Отклики (2)"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OfferTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .systemGray6
        view.addSubview(label)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(332)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-48)
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension OfferViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.systemGray6
        cell.backgroundColor = .systemGray6
        cell.selectedBackgroundView = selectedView
        return cell
    }

}
