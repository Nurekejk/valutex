//
//  SectionHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 11.07.2023.
//

import UIKit
import SnapKit

class SectionHeaderView: UIView {

    private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Сегодня"
            label.font = .systemFont(ofSize: 14)
            label.textColor = .lightGray
            return label
        }()

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
                make.center.equalToSuperview()
            }
//
        }
    }
