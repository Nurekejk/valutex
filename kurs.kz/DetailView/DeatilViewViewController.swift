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
    let names = [
        "Diko", "jame", "Nikol", "Nurbol", "Diko", "jame", "Nikol", "Aigerim"
    ]
    
    let Cname = [
        "Call", "Clip", "California"
    ]
    
    let Dname = [
        "Diko"
    ]
    
    let twoDimensionalArray = [
        ["Diko", "Diar"],
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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let name = twoDimensionalArray[indexPath.section][indexPath.row]
        cell.textLabel?.text = name
        cell.textLabel?.text = "\(name)  Section: \(indexPath.section)  Row: \(indexPath.row)"
        return cell
    }
}
