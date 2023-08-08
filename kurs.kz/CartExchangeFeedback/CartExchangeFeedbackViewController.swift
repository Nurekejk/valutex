//
//  CartExchangeFeedbackViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 13.07.2023.
//

import UIKit
import SnapKit

final class CartExchangeFeedbackViewController: UIViewController {
    
    // MARK: - State
    private var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let languages: [String] = ["Отзывы", "Телефоны", "Время работы", "Email", "Web-site", "Whatsapp"]
    
    private let titleOfIcons: [String] = ["feedbackUser", "phone", "clock", "email", "website", "whatsapp"]
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CartExchangeFeedbackViewCell.self,
            forCellReuseIdentifier: CartExchangeFeedbackViewCell.reuseID)
        tableView.rowHeight = 56
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraits
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.bottom.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

// MARK: - Extension
extension CartExchangeFeedbackViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartExchangeFeedbackViewCell.reuseID,
                                                    for: indexPath) as? CartExchangeFeedbackViewCell
        let language = languages[indexPath.row]
        let titleOfIcon = titleOfIcons[indexPath.row]
        cell?.configureCell(language: language, titleOfIcon: titleOfIcon)
        
        return cell ?? UITableViewCell()
    }
}
