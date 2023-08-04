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
    
    var faqSection: Question? {
        didSet {
            questionTypeLabel.text = faqSection?.question
        }
    }
    
    // MARK: - UI
    private lazy var questionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Что такое Metalink?"
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.regular.s14()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.arrow_down_collapse.uiImage
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var questionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16.0
        stack.distribution = .fill
        return stack
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
        [questionTypeLabel, arrowImageView].forEach {
            questionStackView.addArrangedSubview($0)
        }
        contentView.addSubview(questionStackView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        questionStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
    }
    
    // MARK: - Actions
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? FaqTableHeaderView else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        if collapsed {
            arrowImageView.image = AppImage.arrow_down_collapse.uiImage
        } else {
            arrowImageView.image = AppImage.arrow_up_collapse.uiImage
        }
    }
}
// swiftlint:disable all
// MARK: - FaqTableHeaderViewDelegate Protocol
protocol FaqTableHeaderViewDelegate: FaqViewController {
    func toggleSection(_ header: FaqTableHeaderView, section: Int)
}
// swiftlint:enable all
