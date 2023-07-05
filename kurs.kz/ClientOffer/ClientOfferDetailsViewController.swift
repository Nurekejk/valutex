//
//  ClinetOfferDetailsViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 05.07.2023.
//

import UIKit

class ClientOfferDetailsViewController: UIViewController {

    // MARK: - UI
    private lazy var timerTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы должны совершить обмен \nв течении указанного времени"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private lazy var timerCountDownLabel: UILabel = {
        let label = UILabel()
        label.text = "23 : 58"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private lazy var timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 12.0
        stackView.backgroundColor = UIColor(named: "timerStackViewBackgroundColor")
        stackView.layer.cornerRadius = 8.0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 72, bottom: 24, trailing: 72)

        stackView.addArrangedSubview(self.timerTextLabel)
        stackView.addArrangedSubview(self.timerCountDownLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
        tableView.dataSource = self
        tableView.rowHeight = 50.0
        tableView.frame = CGRect(x: 0, y: 0, width: 100, height: 400)

        return tableView
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(named: "resetButtonBorderColor")?.cgColor
        button.titleLabel?.text = "Отменить"
        button.titleLabel?.textColor = UIColor(named: "resetButtonTextColor")
        return button
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8.0
        stackView.backgroundColor = .orange
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        stackView.addArrangedSubview(self.detailsTableView)
        stackView.addArrangedSubview(self.resetButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16.0
        stackView.backgroundColor = UIColor(named: "clientOfferDetailsBackgroundColor")
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: -16, bottom: 16, trailing: -16)

        stackView.addArrangedSubview(self.timerStackView)
        stackView.addArrangedSubview(self.detailsTableView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
    }
}

extension ClientOfferDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        cell.textLabel?.text = "Status"
        return cell
    }
}
