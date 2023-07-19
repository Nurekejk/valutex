//
//  CalculatorTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit

final class CalculatorTableViewCell: UITableViewCell {

    // MARK: - Public

    public static var reuseIdentifier = String(describing: CalculatorTableViewCell.self)

    // MARK: - UI

        private lazy var containerView: UIView = {
            let view = UIView()
            return view
        }()
}
