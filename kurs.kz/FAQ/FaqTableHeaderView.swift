//
//  FaqTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 01.08.2023.
//

import UIKit

final class FaqTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: FaqTableHeaderView.self)
    var delegate: FaqTableHeaderViewDelegate?
    var section: Int = 0
    
    // MARK: - UI
    private lazy var questionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Что такое Metalink?"
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.regular.s14()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(FaqTableHeaderView.tapHeader(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [questionTypeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        questionTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
        }
    }
    
    // MARK: - Actions
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? FaqTableHeaderView else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
}
// swiftlint:disable all
// MARK: - FaqTableHeaderViewDelegate Protocol
protocol FaqTableHeaderViewDelegate: FaqViewController {
    func toggleSection(_ header: FaqTableHeaderView, section: Int)
}
// swiftlint:enable all
