//
//  SectionHeaderView.swift
//  kurs.kz
//
//  Created by Nurbol on 23.07.2023.
//

import UIKit

final class SectionHeaderView: UIView {
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Отклики (2)"
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.textColor = AppColor.gray100.uiColor
            return label
        }()

    // MARK: - Lifecycle
        override init(frame: CGRect) {
            super.init(frame: frame)

            setupViews()
            setupConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
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
