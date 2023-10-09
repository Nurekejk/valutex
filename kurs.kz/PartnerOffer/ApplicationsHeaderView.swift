//
//  ApplicationsHeaderView.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit
import SnapKit

final class ApplicationsHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: ApplicationsHeaderView.self)
    
    // MARK: - UI
    private let applicationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявки"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = AppFont.semibold.s16()
        label.textAlignment = .left
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
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(applicationsLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        applicationsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Action
    public func setupHeaderCounter(with count: Int) {
        applicationsLabel.text = "Заявки  (\(count))"
    }
}
