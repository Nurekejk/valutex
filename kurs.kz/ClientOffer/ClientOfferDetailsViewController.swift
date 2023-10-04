//
//  ClinetOfferDetailsViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 05.07.2023.
//

import UIKit
import SnapKit

final class ClientOfferDetailsViewController: UIViewController {

    // MARK: - State
    
    private var details : [Detail] = [Detail(type: "Статус", option: "Продажа"),
                                      Detail(type: "Валюта", option: "USD"),
                                      Detail(type: "Курс", option: "500 ₸"),
                                      Detail(type: "Сумма получения", option: "495 $"),
                                      Detail(type: "Обменник", option: "Som Exchange"),
                                      Detail(type: "Адрес обменника", option: "г.Алматы, ул. Ауэзова 14")]
    
    private var timeRemaining: Int = 1800
    private var timer: Timer?
    
    private let service: ClientOfferDetailsService?
    // MARK: - UI
    private lazy var timerTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы должны совершить обмен \nв течении указанного времени"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var timerCountDownLabel: UILabel = {
        let label = UILabel()
        label.text = "\(timeFormatter(timeRemaining))"
        label.textColor = .white
        label.font = AppFont.semibold.s18()
        return label
    }()
    
    private lazy var timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 12.0
        stackView.backgroundColor = AppColor.primaryBase.uiColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24,
                                                                     leading: 72,
                                                                     bottom: 24,
                                                                     trailing: 72)
        return stackView
    }()
    
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OfferDetailsTableViewCell.self,
                           forCellReuseIdentifier: OfferDetailsTableViewCell.reuseID)
        tableView.register(OfferDetailsHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: OfferDetailsHeaderView.reuseID)
        tableView.rowHeight = 50.0
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(cancelButtonDidPress), for: .touchUpInside)
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(AppColor.gray50.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
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
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 16,
                                                                     bottom: 16,
                                                                     trailing: 16)
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
        super.viewDidLayoutSubviews()
        timerStackView.layer.cornerRadius = 8.0

        resetButton.layer.cornerRadius = 12.0
        resetButton.layer.borderWidth = 1.0
        resetButton.layer.borderColor = AppColor.gray30.cgColor
        
        detailsStackView.layer.cornerRadius = 8.0
    }
    
    // MARK: - Initializers
    init(detailsData: [String], service: ClientOfferDetailsService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        setupDetails(with: detailsData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = AppColor.gray10.uiColor
        
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
    @objc func cancelButtonDidPress() {
        service?.deleteOffer(completion: { [weak self] result in
            switch result {
            case .success(let result):
                print("success: \(result)")
            case .failure(let error):
                print("error deleting offer: \(error)")
            }
        })
    }
    private func setupDetails(with detailsData:[String]) {
        var index = 0
        for detail in detailsData {
            details[index].option = detail
        }
        detailsTableView.reloadData()
    }
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
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

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ClientOfferDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfferDetailsTableViewCell.reuseID,
            for: indexPath) as? OfferDetailsTableViewCell
        else {
            fatalError("Could not cast to OfferDetailsTableViewCell")
        }
        cell.detail = details[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    OfferDetailsHeaderView.reuseID)
                as? OfferDetailsHeaderView
        else {
            fatalError("Could not cast to OfferDetailsHeaderView")
        }
        return view
    }
}
