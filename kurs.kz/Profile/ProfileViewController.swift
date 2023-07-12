//
//  ProfileViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 12.07.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var informationTableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.register(ProfileTableViewCell.self,
                               forCellReuseIdentifier: ProfileTableViewCell.reuseID)
            tableView.register(ProfileTableHeaderView.self,
                               forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.reuseID)
            tableView.rowHeight = 50.0
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
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
        view.backgroundColor = .white
        view.addSubview(informationTableView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        informationTableView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(124)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview()
        }

    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseID,
            for: indexPath) as? ProfileTableViewCell
        else {
            fatalError("Could not cast to ProfileTableViewCell")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    ProfileTableHeaderView.reuseID)
                as? ProfileTableHeaderView
        else {
            fatalError("Could not cast to ProfileTableHeaderView")
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 148
    }
}
