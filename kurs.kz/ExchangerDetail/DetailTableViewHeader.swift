//
//  CollapsibleTableViewHeader.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit

final class DetailTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: DetailTableViewHeader.self)
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    var detailSection: DetailSection? {
        didSet {
            iconImageView.image = detailSection?.iconImage
            titleLabel.text = detailSection?.name
        }
    }
    
    // MARK: - UI
    public let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = AppColor.gray100.uiColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = AppFont.regular.s14()
        return titleLabel
    }()
    
    public lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.arrow_down_collapse.uiImage
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(DetailTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .white
        [iconImageView, titleLabel, arrowImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(18)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(16)
        }
    }
    
    // MARK: - Actions
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? DetailTableViewHeader else {
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
