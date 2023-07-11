//
//  CurrencySelectorViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit
import SnapKit

final class CurrencySelectorViewController: UIViewController {
    
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
    
    // MARK: - UI
    
    private let currenciesDictionary = ["Доллар США" : "usd_flag","Евро" : "euro_flag",
                                        "Рос.рубль" : "ru_flag", "Кирг.сом" : "kgs_flag",
                                        "Кит.юань" : "cn_flag"]
    private let currenciesKeyArray = ["Доллар США", "Евро", "Рос.рубль", "Кирг.сом",
                                      "Кит.юань"]
    private lazy var curreniesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CurrencySelectorTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 56
        
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
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        curreniesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITextViewDelegate
extension CurrencySelectorViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currenciesKeyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as? CurrencySelectorTableViewCell
        let dictionaryKey = currenciesKeyArray[indexPath.row]
        if let flagName = currenciesDictionary[dictionaryKey] {
            cell?.configureCell(currency: currenciesKeyArray[indexPath.row], flagName: flagName)
            let customSelectionView = UIView()
            customSelectionView.backgroundColor = UIColor.white
            cell?.selectedBackgroundView = customSelectionView
            return cell ?? UITableViewCell()
        } else {
            return UITableViewCell()
        }
    }
    
}
