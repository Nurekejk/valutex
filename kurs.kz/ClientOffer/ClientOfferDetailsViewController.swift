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
