//
//  ToSupportViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 11/7/23.
//

import UIKit
import SnapKit

final class ToSupportViewController: UIViewController {
    
    // MARK: - UI
    private let supportTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SupportTableViewCell.self, forCellReuseIdentifier: SupportTableViewCell.identifier)
        tableView.rowHeight = 54
        return tableView
    }()
    private let supportOptions: [(image: UIImage?, title: String)] = [
        (AppImage.telegram_icon.uiImage, "Telegram"),
        (AppImage.whatsapp_icon.uiImage, "WhatsApp")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
        setupTableView()
        viewLayoutSubViews()
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Написать в поддержку"
    }
    
    // MARK: - ViewLayoutSubViews
    private func viewLayoutSubViews() {
        super.viewDidLayoutSubviews()
        supportTableView.layer.cornerRadius = 8
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        view.addSubview(supportTableView)
        supportTableView.backgroundColor = AppColor.gray10.uiColor
    }
    
    // MARK: - SetupConstraints()
    private func setupConstraints() {
        supportTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(108)
        }
    }
    
    // MARK: - SetupTableView
    private func setupTableView() {
        supportTableView.dataSource = self
        supportTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ToSupportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportOptions.count
    }
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SupportTableViewCell.identifier,
                                                       for: indexPath) as? SupportTableViewCell else {
            fatalError("Failed to dequeue the right king of cell.")
        }
        cell.configure(with: supportOptions[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        if indexPath.section == SectionNumber.zero.rawValue {
            switch row {
            case 0:
                openTelegram()
            case 1:
                openWhatsApp()
            default:
                break
            }
        }
    }
    // swiftlint: disable all
    private func openTelegram() {
        if let telegramURL = URL(string: "https://t.me/+77052511606"), UIApplication.shared.canOpenURL(telegramURL) {
            UIApplication.shared.open(telegramURL, options: [:], completionHandler: nil)
        } else {
            if let appStoreURL = URL(string: "https://apps.apple.com/app/telegram-messenger/id686449807") {
                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            }
        }
    }
    private func openWhatsApp() {
        let urlString = "https://api.whatsapp.com/send/?phone=77052511606&text=%D0%B4%D0%BE%D0%B1%D1%80%D1%8B%D0%B9%20%D0%B4%D0%B5%D0%BD%D1%8C,%20%D0%BC%D0%BD%D0%B5%20%D0%BD%D1%83%D0%B6%D0%BD%D0%B0%20%D1%82%D0%B5%D1%85%D0%BD%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F%20%D0%BF%D0%BE%D0%B4%D0%B4%D0%B5%D1%80%D0%B6%D0%BA%D0%B0,%20%D0%B2%20%D1%87%D0%B0%D1%81%D1%82%D0%BD%D0%BE%D1%81%D1%82%D0%B8%20..."
        if let whatsappURL = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            } else {
                if let appStoreURL = URL(string: "https://apps.apple.com/app/whatsapp-messenger/id310633997") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
                // swiftlint: enable all
            }
        } else {
            print("Неверный URL для WhatsApp")
        }
    }
}
