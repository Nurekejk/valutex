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
    
    private var timeRemaining: Int = 1800
    private var timer: Timer?
    
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
        label.text = "\(timeFormatter(timeRemaining))"
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
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OfferDetailsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(OfferDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.rowHeight = 50.0
        tableView.dataSource = self
        tableView.delegate = self
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
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        startTimer()
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
        
        timerStackView.addArrangedSubview(self.timerTextLabel)
        timerStackView.addArrangedSubview(self.timerCountDownLabel)
        
        detailsStackView.addArrangedSubview(self.detailsTableView)
        detailsStackView.addArrangedSubview(self.resetButton)
        
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
            make.top.equalTo(detailsStackView.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(352)
        }

        resetButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(52)
        }
    }
    
    // MARK: - Actions
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func timeFormatter(_ seconds: Int) -> String {
        let minutes = Int(timeRemaining)/60 % 60
        let seconds = Int(timeRemaining) % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
    
    @objc private func updateTime() {
        if timeRemaining >= 0 {
            timerCountDownLabel.text = "\(timeFormatter(timeRemaining))"
            timeRemaining -= 1
        } else {
            timer?.invalidate()
        }
    }
}

extension ClientOfferDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OfferDetailsTableViewCell
        cell?.detail = details[indexPath.row]
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! OfferDetailsHeaderView
        return view
    }
}
