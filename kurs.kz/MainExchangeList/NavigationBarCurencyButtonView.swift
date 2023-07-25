import UIKit
import PanModal

final class NavigationBarCurencyButtonView: UIView {
    // MARK: - Static
    public func changeCurrency (newFlagImage: String,
                                newCurrencyLabel: String) {
        flagImageLabel.text = newFlagImage
        currencyLabel.text = newCurrencyLabel
    }
    
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let flagImageLabel: UILabel = {
        let imageView = UILabel()
        return imageView
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    private lazy var selectCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "main_down_arrow"), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        self.addSubview(containerView)
        [flagImageLabel,
         currencyLabel,
         selectCurrencyButton].forEach {containerView.addSubview($0) }
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        flagImageLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.top.equalTo(containerView.snp.top).offset(6)
            make.height.equalTo(12)
            make.width.equalTo(18)
        }
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageLabel.snp.trailing).offset(4)
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
}
