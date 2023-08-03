//
//  CollapsibleTableViewHeader.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: TableViewHeader.self)
    var delegate: TableViewHeaderDelegate?
    var section: Int = 0
    
    // MARK: - UI
    public let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    public lazy var arrowLabel: UILabel = {
        let arrowLabel = UILabel()
        arrowLabel.textColor = .black
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        return arrowLabel
    }()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(TableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .white
        
        [iconImageView, titleLabel, arrowLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(18)
        }
    }
    
    // MARK: - Actions
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? TableViewHeader else {
            return
        }
        
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        if collapsed {
            iconImageView.image = AppImage.arrow_down_collapse.uiImage
        } else {
            iconImageView.image = AppImage.arrow_up_collapse.uiImage
        }
    }
}
// swiftlint:disable all
// MARK: - FaqTableHeaderViewDelegate Protocol
protocol TableViewHeaderDelegate: DetailViewCollabsibleViewController {
    func toggleSection(_ header: TableViewHeader, section: Int)
}
// swiftlint:enable all
