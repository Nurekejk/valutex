//
//  OfferViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 09.07.2023.
//

import UIKit

final class OfferViewController: UIViewController {

    // MARK: - Outlets
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Отклики (2)"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConctraints()
    }
    
    // MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .systemGray6
        view.addSubview(label)
    }

    private func setupConctraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(332)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-48)
            make.height.equalTo(20)
        }

    }

}
