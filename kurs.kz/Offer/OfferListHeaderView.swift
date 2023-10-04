//
//  OfferListHeaderView.swift
//  kurs.kz
//
//  Created by Nurbol on 23.07.2023.
//

import UIKit

final class OfferListHeaderView: UITableViewHeaderFooterView {
    // MARK: - Public
    public static var reuseIdentifier = String(describing: OfferListHeaderView.self)
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Отклики"
            label.font = AppFont.semibold.s16()
            label.textColor = AppColor.gray100.uiColor
            return label
        }()

    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
    
    // MARK: - Action
    public func updateLabel(with responseCount: Int) {
        titleLabel.text = "Отклики (\(responseCount))"
    }

    // MARK: - Setup Views
        private func setupViews() {

            addSubview(titleLabel)
        }

        // MARK: - Setup Constraints
        private func setupConstraints() {
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.centerY.equalToSuperview()
            }
        }
}
