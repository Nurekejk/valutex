//
//  ToSupportViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 11/7/23.
//

import UIKit
import SnapKit

final class ToSupportViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Написать в поддержку"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let supportTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SupportTableViewCell.self, forCellReuseIdentifier: SupportTableViewCell.identifier)
        return tableView
    }()
    
    private let supportOptions: [(image: UIImage?, title: String)] = [
        (UIImage(named: "telegram_icon"), "Telegram"),
        (UIImage(named: "whatsapp_icon"), "WhatsApp")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(supportTableView)
        
        titleLabel.snp.makeConstraints { make in // corrected "male" to "make"
            make.top.equalTo(view.safeAreaLayoutGuide).offset(18)
            make.leading.trailing.equalToSuperview()
        }
        
        supportTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        supportTableView.dataSource = self
        supportTableView.delegate = self
    }
}

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
