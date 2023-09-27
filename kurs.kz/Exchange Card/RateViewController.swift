import UIKit
import SnackBar_swift

final class RateViewController: UIViewController, UITextViewDelegate {
    // MARK: - Properties
    private let officeId: Int
    private let service: RateViewControllerService
    private lazy var rating = oldRating ?? 0 {
        didSet {
            
            isRatingDifferent = rating != oldRating
        }
    }
    private var oldRating: Int?

    private var isRatingDifferent = false {
        didSet {
            if isRatingDifferent || isTextDifferent {
                continueButton.backgroundColor = isTextDifferent || isRatingDifferent ?
                    AppColor.primaryBase.uiColor : AppColor.primaryBase.uiColor.withAlphaComponent(0.64)
                
                continueButton.isEnabled = isTextDifferent || isRatingDifferent
            }
        }
    }
    
    private var isTextDifferent = false {
        didSet {
            if isRatingDifferent || isTextDifferent {
                continueButton.backgroundColor = isTextDifferent || isRatingDifferent ?
                    AppColor.primaryBase.uiColor : AppColor.primaryBase.uiColor.withAlphaComponent(0.64)
                
                continueButton.isEnabled = isTextDifferent || isRatingDifferent
            }
        }
    }
    private var hasGivenFeedbackBefore = false {
        didSet {
            if oldReview != nil {
                continueButton.setTitle("Изменить отзыв", for: .normal)
                reviewTextView.textColor = AppColor.gray100.uiColor

            } else {
                continueButton.setTitle("Отправить отзыв", for: .normal)
                reviewTextView.textColor = AppColor.gray50.uiColor

            }
        }
    }
    private var oldReview: String?
    private var userReviews = [ReviewForTableView]() {
        didSet {
            self.reviewsTableView.reloadData()
        }
    }
    
    // MARK: - UI
    private var starButtons = [StarButton]()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Теперь напишите отзыв"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
        textView.text = "Поделитесь мнением об обменнике?"
        textView.textColor = AppColor.gray50.uiColor
        textView.font = AppFont.regular.s14()
        textView.returnKeyType = .done
        return textView
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить отзыв", for: .normal)
        button.addTarget(self, action: #selector(sendReview), for: .touchUpInside)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        return button
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0,
                                                                     bottom: 16, trailing: 0)
        return stackView
    }()
    private lazy var reviewsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ReviewTableViewCell.self,
                           forCellReuseIdentifier: ReviewTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private func addButtonsToStarStackView() {
        let numberOfButtons = 5
        for _ in 1...numberOfButtons {
            let starButton = StarButton()
            starButton.addTarget(self, action: #selector(changeStars), for: .touchUpInside)
            starButtons.append(starButton)
            starStackView.addArrangedSubview(starButton)
        }
    }
    // MARK: - Initializers
    init(service: RateViewControllerService, officeId: Int) {
        self.service = service
        self.officeId = officeId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        getFeedback()
        fetchReviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reviewTextView.layer.cornerRadius = 8
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.borderColor = AppColor.grayWhite.cgColor
        continueButton.layer.cornerRadius = 12
        entireStackView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(entireStackView)
        view.addSubview(reviewsTableView)
        
        [starStackView, reviewLabel, borderView,
         reviewTextView, continueButton].forEach { entireStackView.addArrangedSubview($0) }
        
        addButtonsToStarStackView()
        
        view.backgroundColor = AppColor.gray10.uiColor
        borderView.backgroundColor = AppColor.gray10.uiColor
        continueButton.backgroundColor = AppColor.primaryBase.uiColor
        entireStackView.backgroundColor = AppColor.grayWhite.uiColor
        
    }
    
    // MARK: - Action
    private func calculateAverageScore() -> Double? {
        var scoresTotal = 0
        for userReview in userReviews {
            guard let score = userReview.score else {return nil}
            scoresTotal += score
        }
        return Double(scoresTotal) / Double(userReviews.count)
    }
    
    private func getFeedback() {
        service.getReview(officeId: officeId) { [weak self] result in
            switch result {
            case .success(let review):
                self?.setupFeedback(with: review)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupFeedback(with review: FeedbackResponse) {
        if review.status ?? false {
            oldReview = review.feedback?.comment
            hasGivenFeedbackBefore = review.status ?? false
            continueButton.isEnabled = false
            continueButton.backgroundColor = AppColor.primaryBase.uiColor.withAlphaComponent(0.64)
            oldRating = review.feedback?.score ?? 0
            var index = 0
            while index != oldRating {
                starButtons[index].isSelected = true
                index += 1
            }
            reviewTextView.text = review.feedback?.comment
        }
    }
    private func fetchReviews() {
        service.fetchUserReviews(officeId: officeId) { [weak self] result in
            switch result {
            case .success(let result):
                self?.userReviews = result
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func changeStars(sender: UIButton!) {
        starButtons.forEach { $0.isSelected = false }
        for (index, element) in starButtons.enumerated() {
            starButtons[index].isSelected = true
            if element == sender {
                rating = index + 1
                break
            }
        }
    }
    
    @objc private func sendReview() {
        if !hasGivenFeedbackBefore {
            if rating == 0 || reviewTextView.text.isEmpty {
            } else {
                let comment = reviewTextView.text!
                let review = Feedback(officeId: officeId, score: rating, comment: comment)
                service.postReview(review: review) { [weak self] result in
                    switch result {
                    case .success:
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("error while posting review")
                    }
                }
            }
        } else {
            if rating == 0 || reviewTextView.text.isEmpty {
                print("cant ")
            } else {
                let comment = reviewTextView.text!
                let review = Feedback(officeId: officeId, score: rating, comment: comment)
                service.updateFeedback(review: review) { [weak self] result in
                    switch result {
                    case .success:
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("error while posting review")
                    }
                }
            }
        }
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        entireStackView.snp.makeConstraints { make in
            make.height.equalTo(318)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(entireStackView.snp.leading)
            make.trailing.equalTo(entireStackView.snp.trailing)
        }
        reviewLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        reviewTextView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.leading.equalTo(entireStackView.snp.leading).offset(16)
            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
        }
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.equalTo(entireStackView.snp.leading).offset(16)
            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
        }
        reviewsTableView.snp.makeConstraints { make in
            make.top.equalTo(entireStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            
        }
    }
}

// MARK: - UITextViewDelegate
extension RateViewController {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == AppColor.gray50.uiColor {
            textView.text = nil
            textView.textColor = AppColor.gray100.uiColor
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        guard hasGivenFeedbackBefore else { return }
        isTextDifferent = textView.text != oldReview
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Поделитесь мнением об обменнике ?"
            textView.textColor = AppColor.gray50.uiColor
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
}
    // MARK: - Extension TableViewDelegate, UITableViewDataSource
extension RateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        102
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseID,
                                                       for: indexPath) as? ReviewTableViewCell
        else { return UITableViewCell() }
        cell.setupCell(with: userReviews[indexPath.row])
        return cell
    }
}
