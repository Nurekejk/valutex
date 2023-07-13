//
//  ProfileViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 12.07.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - States
    private let profileSections: [ProfileSection] =
                                                     [ProfileSection(imageString: "bitcoinExchange",
                                                                     name: "Мои обменники"),
                                                     ProfileSection(imageString: "moneys",
                                                                    name: "Курс валют"),
                                                     ProfileSection(imageString: "setting-3",
                                                                    name: "Настройки аккаунта"),
                                                     ProfileSection(imageString: "notification",
                                                                    name: "Уведомления"),
                                                     ProfileSection(imageString: "language-circle",
                                                                    name: "Язык приложения"),
                                                     ProfileSection(imageString: "global",
                                                                    name: "Город"),
                                                     ProfileSection(imageString: "profile-2user",
                                                                    name: "Стать партнером"),
                                                     ProfileSection(imageString: "messages",
                                                                    name: "Написать в поддержку"),
                                                     ProfileSection(imageString: "info",
                                                                    name: "О компании"),
                                                     ProfileSection(imageString: "message-question",
                                                                    name: "FAQ"),
                                                     ProfileSection(imageString: "bank",
                                                                    name: "Курс Нацбанка")]
    
    // MARK: - UI
    private lazy var informationTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
            tableView.register(ProfileTableViewCell.self,
                               forCellReuseIdentifier: ProfileTableViewCell.reuseID)
            tableView.register(ProfileTableHeaderView.self,
                               forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.reuseID)
            tableView.rowHeight = 54.0
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
            make.edges.equalToSuperview()
        }

    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 1
        if section == 0 {
            rowCount = 10
        }
        if section == 1 {
            rowCount = 1
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseID,
            for: indexPath) as? ProfileTableViewCell
        else {
            fatalError("Could not cast to ProfileTableViewCell")
        }
        
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.profileSection = profileSections[indexPath.row]
        } else {
            cell.profileSection = profileSections[10]
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
        return section == 0 ? 196 : 0
    }
}
