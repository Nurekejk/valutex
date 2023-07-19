//
//  OfferSellBuySegmentedController.swift
//  kurs.kz
//
//  Created by MacBook on 19.07.2023.
//

 import UIKit
 import SnapKit

 final class OfferSellBuySegmentedController: UIViewController {
     
    // MARK: - Properties
    private let buttonBlueColor = UIColor(
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1)

    private let borderGrayColor = UIColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1)

    private let backgroundGrayColor = UIColor(
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1)

    private let textGrayColor = UIColor(
        red: 147.0 / 255.0,
        green: 153.0 / 255.0,
        blue: 171.0 / 255.0,
        alpha: 1)

    // MARK: - UI
     private let segmentedControl: UISegmentedControl = {
         let segmentedControl = UISegmentedControl(items: ["Продать", "Купить"])
         segmentedControl.selectedSegmentIndex = 0
         return segmentedControl
     }()
     
     private lazy var buyViewController = OfferSellViewController(mode: .sell)
     private lazy var sellViewController = OfferSellViewController(mode: .buy)
     

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = backgroundGrayColor

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
    }
     
     // MARK: - Actions
     @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
     }
 }
