//
//  Delegate.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit
import CollapsibleTableSectionViewController

protocol CollapsibleTableViewHeaderDelegate: UIViewController {
    func toggleSection(_ header: DetailTableViewHeader, section: Int)
}
