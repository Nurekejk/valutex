//
//  CurrencySelectorViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit

final class CurrencySelectorViewController: UIViewController, UITextViewDelegate {
    
    private let buttonBlueColor = UIColor(
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1)
    
    private let borderGrayColor = CGColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1)
    
    private let backgroundGrayColor = UIColor(
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1)
    
    private var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            curreniesTableView.reloadData()
        }
    }

    
    // MARK: - UI
    
    private let currencies = ["Доллар США",]
    private let curreniesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    //    private var starButtons = [StarButton]()
    //
    //    private let starStackView: UIStackView = {
    //        let stackView = UIStackView()
    //        stackView.axis = .horizontal
    //        stackView.spacing = 4
    //        stackView.alignment = .fill
    //        stackView.distribution = .equalSpacing
    //        return stackView
    //    }()
    //
    //    private let reviewLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Теперь напишите отзыв"
    //        label.textColor = .lightGray
    //        label.font = .systemFont(ofSize: 14)
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    //
    //    private let reviewTextView: UITextView = {
    //        let textView = UITextView()
    //        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
    //        textView.text = "Поделитесь мнением об обменнике?"
    //        textView.textColor = .lightGray
    //        textView.font = .systemFont(ofSize: 14)
    //        textView.returnKeyType = .done
    //        return textView
    //    }()
    //
    //    private let borderView: UIView = {
    //        let view = UIView()
    //        return view
    //    }()
    //
    //    private let continueButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.setTitle("Отправить отзыв", for: .normal)
    //        button.titleLabel?.font =  .systemFont(ofSize: 16, weight: .bold)
    //        button.setTitleColor(.white, for: .normal)
    //        return button
    //    }()
    //
    //    private let entireStackView: UIStackView = {
    //        let stackView = UIStackView()
    //        stackView.axis = .vertical
    //        stackView.spacing = 16
    //        stackView.alignment = .center
    //        stackView.distribution = .fill
    //        stackView.isLayoutMarginsRelativeArrangement = true
    //        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0,
    //                                                                     bottom: 16, trailing: 0)
    //        return stackView
    //    }()
    //
    //    private func addButtonsToStarStackView() {
    //        let numberOfButtons = 5
    //        for _ in 1...numberOfButtons {
    //            let starButton = StarButton()
    //            starButton.addTarget(self, action: #selector(changeStars), for: .touchUpInside)
    //            starButtons.append(starButton)
    //            starStackView.addArrangedSubview(starButton)
    //        }
    //    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        reviewTextView.layer.cornerRadius = 8
        //        reviewTextView.layer.borderWidth = 1
        //        reviewTextView.layer.borderColor = borderGrayColor
        //        continueButton.layer.cornerRadius = 12
        //        entireStackView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(curreniesTableView)
        curreniesTableView.dataSource = self
        curreniesTableView.delegate = self
        //        view.addSubview(entireStackView)
        //
        //        [starStackView, reviewLabel, borderView,
        //         reviewTextView, continueButton].forEach { entireStackView.addArrangedSubview($0) }
        //
        //        addButtonsToStarStackView()
        //
        //        view.backgroundColor = backgroundGrayColor
        //        borderView.backgroundColor = backgroundGrayColor
        //        continueButton.backgroundColor = buttonBlueColor
        //        entireStackView.backgroundColor = .white
        //
        //        reviewTextView.delegate = self
        
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
//        entireStackView.snp.makeConstraints { make in
//            make.height.equalTo(318)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//            make.top.equalToSuperview().offset(116)
//        }
//        borderView.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.leading.equalTo(entireStackView.snp.leading)
//            make.trailing.equalTo(entireStackView.snp.trailing)
//        }
//        reviewLabel.snp.makeConstraints { make in
//            make.height.equalTo(18)
//        }
//        reviewTextView.snp.makeConstraints { make in
//            make.height.equalTo(120)
//            make.leading.equalTo(entireStackView.snp.leading).offset(16)
//            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
//        }
//        continueButton.snp.makeConstraints { make in
//            make.height.equalTo(52)
//            make.leading.equalTo(entireStackView.snp.leading).offset(16)
//            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
//        }
    }
}
//    // MARK: - Action
//    @objc func changeStars(sender: UIButton!) {
//        starButtons.forEach { $0.isSelected = false }
//        for (index, element) in starButtons.enumerated() {
//            starButtons[index].isSelected = true
//            if element == sender {
//                break
//            }
//        }
//    }
//}

// MARK: - UITextViewDelegate
extension CurrencySelectorViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

}

