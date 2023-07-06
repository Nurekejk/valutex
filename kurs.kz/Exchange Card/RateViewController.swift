import UIKit

final class RateViewController: UIViewController {
    // MARK: - UI
    private var starArray = [StarButton]()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .red
        return stackView
    }()
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Теперь напишите отзыв"
        label.font = .systemFont(ofSize: 14)
        label.backgroundColor = .blue
        return label
    }()
    private let reviewTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поделитесь мнением об обменнике ?"
        return textField
    }()
    override func viewDidLayoutSubviews() {
        
    }
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0,
                                                                     bottom: 16, trailing: 0)
        stackView.backgroundColor = .red
        return stackView
    }()
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0,
                                                                     bottom: 16, trailing: 0)
        stackView.backgroundColor = .red
        return stackView
    }()
    private func addButtonsToStarStackView() {
        let numberOfButtons = 5
        for _ in 1...numberOfButtons {
            let starButton = StarButton()
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
        
        view.addSubview(topStackView)
        topStackView.addArrangedSubview(starStackView)
        topStackView.addArrangedSubview(reviewLabel)
        addButtonsToStarStackView()
        
        view.backgroundColor = .gray
    }
    
    // MARK: - Constraints:
    private func setupConstraints() {
        topStackView.snp.makeConstraints { make in
            make.height.equalTo(98)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(116)
        }
    }
}

