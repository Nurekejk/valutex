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
