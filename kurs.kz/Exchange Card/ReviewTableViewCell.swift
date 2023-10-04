//
//  ReviewTableViewCell.swift
//  kurs.kz
//
//  Created by MacBook on 26.09.2023.
//

import UIKit
import SnapKit

final class ReviewTableViewCell: UITableViewCell {
    // MARK: - State
    static let reuseID = String(describing: ReviewTableViewCell.self)
    
    var review: ReviewForTableView? {
        didSet {
            fullNameLabel.text = review?.fullName
            dateLabel.text = getDate(from: review?.createdAt ?? "")
            reviewTextView.text = review?.comment
            setupScore(with: review?.score)
        }
    }
    
    // MARK: - Properties
    private var starImages: [UIImageView] = {
        var starImagesArray = [UIImageView]()
        for _ in 1...5 {
            let starImageView = UIImageView(image: AppImage.gray_star.uiImage)
            starImagesArray.append(starImageView)
        }
        return starImagesArray
    }()
    
    // MARK: - UI
    private let fullNameLabel: UILabel = {
       let label = UILabel()
        label.font = AppFont.bold.s14()
        label.textColor = AppColor.gray100.uiColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var starImagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .left
        textView.textColor = AppColor.gray100.uiColor
        textView.font = AppFont.regular.s14()
        return textView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular.s14()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup Views
    private func setupViews() {
        [fullNameLabel, reviewTextView,
         dateLabel, starImagesStackView].forEach {contentView.addSubview($0)}
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(215)
        }
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(dateLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-16)
            
        }
        starImagesStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(96)
            make.height.equalTo(16)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Action
    private func setupScore(with score: Int?) {
        guard let unwrappedScore = score else { return }
        print(starImages)
        for index in 1...unwrappedScore {
            print(index)
            let goldenStarImageView = UIImageView(image: AppImage.golden_star.uiImage)
            starImages[index - 1] = goldenStarImageView
        }
        for star in starImages {
            starImagesStackView.addArrangedSubview(star)
        }
    }
    
    func getDate(from dateString: String) -> String {
        if let dotIndex = dateString.firstIndex(of: ".") {
            let trimmedDate = String(dateString[..<dotIndex])
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: trimmedDate + "Z") {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd.MM.yy"
                // dd MMMM yyyy, HH:mm:ss
                outputFormatter.timeZone = TimeZone.current
                
                return outputFormatter.string(from: date)
            }
        }
        return "error processing date"
    }
    
    // MARK: - Public
    public func setupCell(with review: ReviewForTableView) {
        self.review = review
    }
}
