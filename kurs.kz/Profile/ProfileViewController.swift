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
    [ProfileSection(image: AppImage.bitcoin_exchange.uiImage ?? UIImage(),
                    name: "Мои обменники"),
     ProfileSection(image: AppImage.moneys.uiImage ?? UIImage(),
                    name: "Курс валют"),
     ProfileSection(image: AppImage.setting_3.uiImage ?? UIImage(),
                    name: "Настройки аккаунта"),
     ProfileSection(image: AppImage.notification.uiImage ?? UIImage(),
                    name: "Уведомления"),
     ProfileSection(image: AppImage.language_circle.uiImage ?? UIImage(),
                    name: "Язык приложения"),
     ProfileSection(image: AppImage.global.uiImage ?? UIImage(),
                    name: "Город"),
     ProfileSection(image: AppImage.profile_2user.uiImage ?? UIImage(),
                    name: "Стать партнером"),
     ProfileSection(image: AppImage.messages.uiImage ?? UIImage(),
                    name: "Написать в поддержку"),
     ProfileSection(image: AppImage.info.uiImage ?? UIImage(),
                    name: "О компании"),
     ProfileSection(image: AppImage.message_question.uiImage ?? UIImage(),
                    name: "FAQ"),
     ProfileSection(image: AppImage.bank.uiImage ?? UIImage(),
                    name: "Курс Нацбанка")]
    
    // MARK: - UI
    private lazy var informationTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
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
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        informationTableView.layer.cornerRadius = 8
        informationTableView.layer.masksToBounds = true
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: AppImage.logout.uiImage,
            style: .plain,
            target: self,
            action: nil)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        view.addSubview(informationTableView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        informationTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Enumerator
enum SectionNumber: Int {
    case zero = 0
    case one = 1
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 1
        if section == SectionNumber.zero.rawValue {
            rowCount = 10
        }
        if section == SectionNumber.one.rawValue {
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
        
        if indexPath.section == 0 {
            cell.profileSection = profileSections[indexPath.row]
        } else {
            cell.profileSection = profileSections[10]
        }
        
        if cell.profileSection?.name == profileSections[3].name {
            cell.configureCell(isBadgeHidden: false)
        } else {
            cell.configureCell(isBadgeHidden: true)
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
    
    // swiftlint:disable cyclomatic_complexity
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        switch row {
        case 0:
            navigationController?.pushViewController(EmptyViewController(),
                                                     animated: true)
        case 1:
            navigationController?.pushViewController(EmptyViewController(),
                                                     animated: true)
        case 2:
            navigationController?.pushViewController(EmptyViewController(),
                                                     animated: true)
        case 3:
            navigationController?.pushViewController(NotificationsViewController(),
                                                     animated: true)
        case 4:
            navigationController?.pushViewController(LanguageAppViewController(),
                                                     animated: true)
        case 5:
            navigationController?.pushViewController(SelectCityViewController(),
                                                     animated: true)
        case 6:
            navigationController?.pushViewController(EmptyViewController(),
                                                     animated: true)
        case 7:
            navigationController?.pushViewController(ToSupportViewController(),
                                                     animated: true)
        case 8:
            navigationController?.pushViewController(AboutCompanyViewController(),
                                                     animated: true)
        case 9:
            navigationController?.pushViewController(FaqViewController(service: FaqPageService()),
                                                     animated: true)
        default:
            navigationController?.pushViewController(EmptyViewController(),
                                                     animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // swiftlint:enable cyclomatic_complexity
}
