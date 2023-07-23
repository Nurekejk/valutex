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
    let phonesNumber = [
        "8(747) 429 94 13", "8(705) 684 67 10"
    ]
    
    let headersName = [
        "Телефоны", "Время работы", "Email", "Web-site", "Whatsapp"
    ]
    
    var twoDimensionalArray = [
        ["Diko", "Diar", "Aiko", "Liko"],
        ["Diko", "jame", "Nikol", "Nurbol", "Diko", "jame", "Nikol"],
        ["Call"],
        ["Second"],
        ["Third"]
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
        tableView.rowHeight = 76
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
            make.edges.equalToSuperview()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    EmailCell.reuseID, for:
                                                    indexPath)as? EmailCell
        cell?.setupEmail(email: "abs.com")
        
        return cell ?? UITableViewCell()
    }
}
