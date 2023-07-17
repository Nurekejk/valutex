//
//  OfferTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Nurbol on 17.07.2023.
//

import UIKit

class OfferTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - Outlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        return label
    }()
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(titleLabel)
    }
    // MARK: - Setup Constraints

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
