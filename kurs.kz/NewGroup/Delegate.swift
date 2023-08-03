//
//  Delegate.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit
import CollapsibleTableSectionViewController

protocol CollapsibleTableViewHeaderDelegate: AnyObject {
    func toggleSection(_ header: TableViewHeader, section: Int)
}
