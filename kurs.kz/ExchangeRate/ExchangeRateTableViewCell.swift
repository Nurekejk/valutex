//
//  ExchangeRateTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 12.07.2023.
//

import UIKit
import SnapKit

class ExchangeRateTableViewCell: UITableViewCell {
    // MARK: - Public

    public static var reuseIdentifier = String(describing: ExchangeRateTableViewCell.self)

    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Доллар"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var titleFLabel: UILabel = {
        let label = UILabel()
        label.text = "Доллар"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = 8
    }
    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel].forEach {
            containerView.addSubview($0)
        }
        contentView.backgroundColor = .systemGray6
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }
    // MARK: - Setup Constraints

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
    }
}
