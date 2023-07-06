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

    }
    
    // MARK: - Constraints:
    private func setupConstraints() {
    }
}
