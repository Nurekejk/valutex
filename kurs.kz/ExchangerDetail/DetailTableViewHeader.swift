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
    var section: Int = -1
    var isFirstSection: Bool = false
    var isLastSection: Bool = false
    
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
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        if section == 3 {
            contentView.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)
        } else if section == 7 {
            contentView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8.0)
        } else {
            contentView.roundCorners(corners: [.allCorners], radius: 0.0)
        }
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
    
    // MARK: - Setup Gesture Recognizer
    private func setupGestureRecognizer() {
        addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(DetailTableViewHeader.tapHeader(_:))))
    }
    
    // MARK: - Actions
    func checkIfEmpty() {
        if let unwrappedItems = detailSection?.items {
        print(section)
        print("items are: \(unwrappedItems)")
            if unwrappedItems.isEmpty || unwrappedItems == [nil] {
                
                switch section {
                case 3:
                    arrowImageView.isHidden = true
                    titleLabel.text = "Телефоны - не указаны"
                case 4:
                    arrowImageView.isHidden = true
                    titleLabel.text = "Время работы - не указано"
                case 5:
                    arrowImageView.isHidden = true
                    titleLabel.text = "Email - не указан"
                case 6:
                    arrowImageView.isHidden = true
                    titleLabel.text = "Web-site - не указан"
                case 7:
                    arrowImageView.isHidden = true
                    titleLabel.text = "Whatsapp - не указан"
                default:
                    print("something went wrong")
                }
            } else {
                arrowImageView.isHidden = false
            }
        }
    }
    
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

// MARK: - UIView Extension
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
