import UIKit
import PanModal

final class OfferSellCurrencyView: UIView {
    // MARK: - Static
    public func changeCurrency (newFlagImage: String,
                                newCurrencyLabel: String) {
        flagImageView.image = UIImage(named: newFlagImage)
        currencyLabel.text = newCurrencyLabel
    }
    
    // MARK: - Properties
    weak var delegate: OfferSellCurrencyViewDelegate?
    
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    private lazy var selectCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "down_arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        self.addSubview(containerView)
        [flagImageView,
         currencyLabel,
         selectCurrencyButton].forEach {containerView.addSubview($0) }
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        flagImageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.top.equalTo(containerView.snp.top).offset(6)
            make.height.equalTo(12)
            make.width.equalTo(18)
        }
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(4)
            make.top.equalTo(containerView.snp.top).offset(4)
            make.height.equalTo(16)
            make.width.equalTo(26)
        }
        selectCurrencyButton.snp.makeConstraints { make in
            make.leading.equalTo(currencyLabel.snp.trailing).offset(4)
            make.top.equalTo(containerView.snp.top).offset(9.54)
            make.width.equalTo(9)
            make.height.equalTo(4.91)
        }
    }
    // MARK: - Action
    @objc func buttonPressed(sender: UIButton!) {
        delegate?.selectorButtonPressed()
    }
}
    // MARK: - Protocols
protocol OfferSellCurrencyViewDelegate: AnyObject {
    func selectorButtonPressed()
}
