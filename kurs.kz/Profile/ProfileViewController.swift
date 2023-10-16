//
//  ProfileViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 12.07.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let type: UserType
    
    private var profileSections: [ProfileSection] {
        switch type {
        case .customer:
            return [ProfileSection(image: AppImage.accountSettings.uiImage ?? UIImage(),
                                   name: "Настройки аккаунта"),
                    ProfileSection(image: AppImage.language_circle.uiImage ?? UIImage(),
                                   name: "Язык приложения"),
                    ProfileSection(image: AppImage.global.uiImage ?? UIImage(),
                                   name: "Город"),
                    ProfileSection(image: AppImage.messages.uiImage ?? UIImage(),
                                   name: "Написать в поддержку"),
                    ProfileSection(image: AppImage.info.uiImage ?? UIImage(),
                                   name: "О компании"),
                    ProfileSection(image: AppImage.message_question.uiImage ?? UIImage(),
                                   name: "FAQ"),
                    ProfileSection(image: AppImage.bank.uiImage ?? UIImage(),
                                   name: "Курс Нацбанка")]
        case .managerOrOwner:
            return [ProfileSection(image: AppImage.moneys.uiImage ?? UIImage(),
                                   name: "Курс валют"),
                    ProfileSection(image: AppImage.accountSettings.uiImage ?? UIImage(),
                                   name: "Настройки аккаунта"),
                    ProfileSection(image: AppImage.language_circle.uiImage ?? UIImage(),
                                   name: "Язык приложения"),
                    ProfileSection(image: AppImage.global.uiImage ?? UIImage(),
                                   name: "Город"),
                    ProfileSection(image: AppImage.messages.uiImage ?? UIImage(),
                                   name: "Написать в поддержку"),
                    ProfileSection(image: AppImage.info.uiImage ?? UIImage(),
                                   name: "О компании"),
                    ProfileSection(image: AppImage.message_question.uiImage ?? UIImage(),
                                   name: "FAQ"),
                    ProfileSection(image: AppImage.bank.uiImage ?? UIImage(),
                                   name: "Курс Нацбанка")]
        }
    }
    
    private let defaults = UserDefaults.standard
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        let header = informationTableView.headerView(forSection: 0) as? ProfileTableHeaderView
        header?.getUserData()
    }
    
    init(typeOfUser: UserType) {
        self.type = typeOfUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: AppImage.logout.uiImage,
            style: .plain,
            target: self,
            action: #selector(logOutButtonDidPress))
        navigationItem.title = "Профиль"
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
    
    // MARK: - Action
    @objc private func logOutButtonDidPress() {
        let alert = UIAlertController(title: "Выход",
                                      message: "Вы действительно хотите выйти?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да",
                                      style: .destructive,
                                      handler: { [weak self] _ in
            self?.defaults.removeObject(forKey: SignInViewController.defaultsUserAndTokensKey)
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let rootViewController = MainPageViewController()
                let navController = UINavigationController(rootViewController: rootViewController)
                sceneDelegate.window?.rootViewController = navController
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Нет",
                                      style: .cancel,
                                      handler: { _ in }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 1
        if section == SectionNumber.zero.rawValue {
            rowCount = profileSections.count - 1
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
            cell.profileSection = profileSections.last
        }

        cell.configureCell(isBadgeHidden: true)
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
    
    // swiftlint:disable all
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        
        guard let section = SectionNumber(rawValue: indexPath.section) else {
            return
        }
        
        let controller: UIViewController
        switch (section, type, row) {
        case (.zero, .customer, 0):
            controller = AccountSettingsViewController()
        case (.zero, .customer, 1):
            controller = LanguageAppViewController()
        case (.zero, .customer, 2):
            controller = SelectCityViewController()
        case (.zero, .customer, 3):
            controller = ToSupportViewController()
        case (.zero, .customer, 4), (.zero, .customer, 5):
            controller = AboutCompanyViewController(service: AboutCompanyPageService())
        case (.zero, .customer, _):
            controller = EmptyViewController()
        case (.zero, .managerOrOwner, 0):
            controller = ExchangeRateViewController(service: ExchangeRateService())
        case (.zero, .managerOrOwner, 1):
            controller = AccountSettingsViewController()
        case (.zero, .managerOrOwner, 2):
            controller = LanguageAppViewController()
        case (.zero, .managerOrOwner, 3):
            controller = SelectCityViewController()
        case (.zero, .managerOrOwner, 4):
            controller = ToSupportViewController()
        case (.zero, .managerOrOwner, 5), (.zero, .managerOrOwner, 6):
            controller = AboutCompanyViewController(service: AboutCompanyPageService())
        case (.zero, .managerOrOwner, _):
            controller = EmptyViewController()
        case (_, _, _):
            controller = NationalBankCourseViewController(service: NationalBankPageService())
        }
        
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    // swiftlint:enable all

}

    // MARK: - Enumerator
enum UserType {
    case managerOrOwner
    case customer
}

enum SectionNumber: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}
