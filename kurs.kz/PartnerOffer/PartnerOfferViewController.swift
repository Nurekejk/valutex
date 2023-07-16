//
//  PartnerOfferViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit

class PartnerOfferViewController: UIViewController {

    // MARK: - UI
    private lazy var acceptedSendTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PartnerOfferViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
            for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
