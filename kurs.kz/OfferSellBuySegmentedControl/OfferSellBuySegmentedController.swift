//
//  OfferSellBuySegmentedController.swift
//  kurs.kz
//
//  Created by MacBook on 19.07.2023.
//

import UIKit
import SnapKit

final class OfferSellBuySegmentedController: UIViewController {
    // MARK: - UI
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Продать", "Купить"])
        segmentedControl.selectedSegmentIndex = 0
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: AppColor.gray50.uiColor,
            NSAttributedString.Key.font: AppFont.regular.s14()
        ]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: AppColor.gray100.uiColor,
            NSAttributedString.Key.font: AppFont.regular.s14()
        ]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var buyViewController = OfferSellViewController(mode: .sell)
    private lazy var sellViewController = OfferSellViewController(mode: .buy)
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        displayViewController(buyViewController)
    }
    // MARK: - Navigation Bar
    private func navigationBar() {
        title = "Оффер"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(containerView)
        view.addSubview(segmentedControl)
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(132)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(40)
            make.width.equalTo(311)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            displayViewController(buyViewController)
        case 1:
            displayViewController(sellViewController)
        default:
            break
        }
    }
    
    func displayViewController(_ viewController: UIViewController) {
        children.forEach { $0.removeFromParent() }
        addChild(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
