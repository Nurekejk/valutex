//
//  ExchangerScreenViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 15/7/23.
//

import UIKit
import SnapKit

final class ExchangerScreenViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExchangerScreenTableViewCell.self,
                           forCellReuseIdentifier: ExchangerScreenTableViewCell.reuseIdentifier)
        tableView.register(ExchangerScreenTextCellTableViewCell.self,
                           forCellReuseIdentifier:  ExchangerScreenTextCellTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray6
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        let buttonOne = UIBarButtonItem(image:UIImage(named: "button_one_image"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(buttonOneTapped))
        let buttonTwo = UIBarButtonItem(image:UIImage(named: "button_two_image"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(buttonTwoTapped))
        navigationItem.rightBarButtonItems = [buttonOne, buttonTwo]
    }
    
    @objc private func buttonOneTapped() {
           // обработка нажатия на кнопку 1
       }
    @objc private func buttonTwoTapped() {
            // обработка нажатия на кнопку 2
        }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangerScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2  // Return the number of rows you want to display
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Using first cell type for first row, second cell type for second row
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        ExchangerScreenTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? ExchangerScreenTableViewCell
            return cell ?? UITableViewCell()
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        ExchangerScreenTextCellTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? ExchangerScreenTextCellTableViewCell
            return cell ?? UITableViewCell()
        } else {
            return UITableViewCell()  // Return empty cell for any other rows (just in case)
        }
    }
}
