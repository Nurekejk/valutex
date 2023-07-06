import UIKit

final class RateViewController: UIViewController, UITextViewDelegate {
   
    private let borderGrayColor = CGColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1 )
    
    // MARK: - UI
    private var starArray = [StarButton]()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Теперь напишите отзыв"
        label.font = .systemFont(ofSize: 14)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
        textView.text = "Поделитесь мнением об обменнике?"
        textView.textColor = .lightGray
        textView.backgroundColor = .white
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить отзыв", for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        reviewTextView.layer.cornerRadius = 8
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.borderColor = borderGrayColor
        continueButton.layer.cornerRadius = 12
        entireStackView.layer.cornerRadius = 8
         
    }
    
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
    
    private func addButtonsToStarStackView() {
        let numberOfButtons = 5
        for _ in 1...numberOfButtons {
            lazy var starButton = StarButton()
            starArray.append(starButton)
            starStackView.addArrangedSubview(starButton)
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        
        view.addSubview(entireStackView)
        [starStackView, reviewLabel, borderView,
         reviewTextView, continueButton].forEach { entireStackView.addArrangedSubview($0) }
//        topStackView.addArrangedSubview(starStackView)
//        topStackView.addArrangedSubview(reviewLabel)
        
        addButtonsToStarStackView()
        
        view.backgroundColor = .gray
        
        continueButton.backgroundColor = .cyan
        
        entireStackView.backgroundColor = .white
        
        reviewTextView.delegate = self

    }
    
    // MARK: - Constraints:
    private func setupConstraints() {
        entireStackView.snp.makeConstraints { make in
            make.height.equalTo(318)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(116)
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
    }
}

extension RateViewController {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Поделитесь мнением об обменнике ?"
            textView.textColor = UIColor.lightGray
        }
    }
}
