//
//  SelectCityViewController.swift
//  kurs.kz
//
//  Created by Adil on ?.?.?.
//

import UIKit
import Alamofire

final class RateViewController: UIViewController, UITextViewDelegate {

    // MARK: - Public
    public var officeId: Int = 0
    
    // MARK: - State
    private let rateService = RateService()
    private var rates: [Rate] = []

    // MARK: - UI
    private var starButtons = [StarButton]()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Теперь напишите отзыв"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
        textView.text = "Поделитесь мнением об обменнике?"
        textView.textColor = AppColor.gray50.uiColor
        textView.font = AppFont.regular.s14()
        textView.returnKeyType = .done
        return textView
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить отзыв", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        return button
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0,
                                                                     bottom: 16, trailing: 0)
        return stackView
    }()
    
    private func addButtonsToStarStackView() {
        let numberOfButtons = 5
        for _ in 1...numberOfButtons {
            let starButton = StarButton()
            starButton.addTarget(self, action: #selector(changeStars), for: .touchUpInside)
            starButtons.append(starButton)
            starStackView.addArrangedSubview(starButton)
        }
    }
    
    private lazy var header: RateTableViewHeader = {
        let header = RateTableViewHeader()
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(RateCell.self, forCellReuseIdentifier: RateCell.reuseID)
        tableView.tableHeaderView = header
        tableView.dataSource = self
        tableView.rowHeight = 102
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        fetchRates()
    }
    
    // MARK: - ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reviewTextView.layer.cornerRadius = 8
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.borderColor = AppColor.grayWhite.cgColor
        continueButton.layer.cornerRadius = 12
        entireStackView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Оценить"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(entireStackView)
        
        [starStackView, reviewLabel, borderView,
         reviewTextView, continueButton].forEach { entireStackView.addArrangedSubview($0) }
        
        view.addSubview(tableView)
        addButtonsToStarStackView()
        
        view.backgroundColor = AppColor.gray10.uiColor
        borderView.backgroundColor = AppColor.gray10.uiColor
        continueButton.backgroundColor = AppColor.primaryBase.uiColor
        entireStackView.backgroundColor = AppColor.grayWhite.uiColor
        
        reviewTextView.delegate = self

    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        entireStackView.snp.makeConstraints { make in
            make.height.equalTo(318)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(116)
        }
        
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(entireStackView.snp.leading)
            make.trailing.equalTo(entireStackView.snp.trailing)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.leading.equalTo(entireStackView.snp.leading).offset(16)
            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
        }
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.equalTo(entireStackView.snp.leading).offset(16)
            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
        }
        
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 53)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(entireStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(92)
        }
    }
    // swiftlint:disable all
    
    // MARK: - Network
    private func fetchRates() {
        rateService.fetchRates(officeID: officeId) { [weak self] result in
            switch result {
            case .success(let rates):
                self?.rates = rates
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

    }
    // swiftlint:enable all
    
    @objc func changeStars(sender: UIButton!) {
        starButtons.forEach { $0.isSelected = false }
        for (index, element) in starButtons.enumerated() {
            starButtons[index].isSelected = true
            if element == sender {
                break
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension RateViewController: UITableViewDataSource {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == AppColor.gray50.uiColor {
            textView.text = nil
            textView.textColor = AppColor.gray100.uiColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Поделитесь мнением об обменнике ?"
            textView.textColor = AppColor.gray50.uiColor
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RateCell.reuseID,
            for: indexPath) as? RateCell
        
        cell?.setup(rate: rates[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
