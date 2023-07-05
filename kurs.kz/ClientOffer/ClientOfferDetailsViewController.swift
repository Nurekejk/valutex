//
//  ClinetOfferDetailsViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 05.07.2023.
//

import UIKit
import SnapKit

class ClientOfferDetailsViewController: UIViewController {

    // MARK: - State
    
    private let details : [Detail] = [Detail(type: "Статус", option: "Продажа"),
                                      Detail(type: "Валюта", option: "USD"),
                                      Detail(type: "Курс", option: "500 ₸"),
                                      Detail(type: "Сумма получения", option: "495 $"),
                                      Detail(type: "Обменник", option: "Som Exchange"),
                                      Detail(type: "Адрес обменника", option: "г.Алматы, ул. Ауэзова 14")]
    
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
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 72, bottom: 24, trailing: 72)

        stackView.addArrangedSubview(self.timerTextLabel)
        stackView.addArrangedSubview(self.timerCountDownLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OfferDetailsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 50.0
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor( UIColor(named: "resetButtonTextColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        return button
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16.0
        stackView.backgroundColor = .white
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        stackView.addArrangedSubview(self.detailsTableView)
        stackView.addArrangedSubview(self.resetButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        timerStackView.layer.cornerRadius = 8.0
        
        resetButton.layer.cornerRadius = 12.0
        resetButton.layer.borderWidth = 1.0
        resetButton.layer.borderColor = UIColor(named: "resetButtonBorderColor")?.cgColor
        
        detailsStackView.layer.cornerRadius = 8.0
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = UIColor(named: "offerDetailsBackgroundColor")
        
        view.addSubview(timerStackView)
        view.addSubview(detailsStackView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        timerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(timerStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        detailsTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(300)
        }

        resetButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(52)
        }
    }
}

extension ClientOfferDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OfferDetailsTableViewCell
        cell?.detail = details[indexPath.row]
        return cell ?? UITableViewCell()
    }
}
