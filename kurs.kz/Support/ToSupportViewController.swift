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
        
        setupViews()
        setupConstraints()
        setupTableView()
        
    }
    
    // MARK: - ViewLayoutSubViews
    private func viewLayoutSubViews() {
        super.viewDidLayoutSubviews()
        supportTableView.layer.cornerRadius = 8
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        title = "Написать в поддержку"
        navigationController?.navigationBar.backItem?.title = ""
        
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
}
