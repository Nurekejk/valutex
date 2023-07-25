//
//  DeatilViewViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 22.07.2023.
//

import UIKit
import SnapKit

final class DeatilViewViewController: UIViewController {
    
    // MARK: - State
    let headersName = [
        "Телефоны", "Время работы", "Email", "Web-site", "Whatsapp"
    ]
    
    // MARK: - UI
    private lazy var header: HeaderView = {
        let header = HeaderView()
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        tableView.register(PhoneCell.self, forCellReuseIdentifier: PhoneCell.reuseID)
        tableView.register(EmailCell.self, forCellReuseIdentifier: EmailCell.reuseID)
        tableView.register(ClockTimeCell.self, forCellReuseIdentifier: ClockTimeCell.reuseID)
        tableView.register(FeedBackCell.self, forCellReuseIdentifier: FeedBackCell.reuseID)
        tableView.register(WebSiteCell.self, forCellReuseIdentifier: WebSiteCell.reuseID)
        tableView.register(FeedBackCommentCell.self, forCellReuseIdentifier: FeedBackCommentCell.reuseID)
        tableView.rowHeight = 140
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.layer.cornerRadius = 8
        
        setupViews()
        setupConstraits()
    }
    
    // MARK: - Setup Views
    func setupViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Constraits
    func setupConstraits() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(108)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(650)
        }
    }
}

// MARK: - Extension
extension DeatilViewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "phone")
        
        let label = UILabel()
        label.text = "Телефон"
        label.font = .systemFont(ofSize: 16)
        
        view.addSubview(image)
        view.addSubview(label)
        
        image.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(image.snp.trailing).offset(16)
            make.height.equalTo(18)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedBackCell.reuseID,
                                                     for: indexPath) as? FeedBackCell

            return cell ?? UITableViewCell()
        }

        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedBackCommentCell.reuseID,
                                                     for: indexPath) as? FeedBackCommentCell
            
            return cell ?? UITableViewCell()
        }

        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhoneCell.reuseID,
                                                     for: indexPath) as? PhoneCell
            
            return cell ?? UITableViewCell()
        }

        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.reuseID,
                                                     for: indexPath) as? EmailCell
            
            return cell ?? UITableViewCell()
        }
        
        return UITableViewCell()
    }
}
