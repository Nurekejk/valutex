//
//  Delegate.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit
import CollapsibleTableSectionViewController

// swiftlint:disable all
protocol CollapsibleTableViewHeaderDelegate: UIViewController {
    func toggleSection(_ header: DetailTableViewHeader, section: Int)
}
// swiftlint:enable all
