//
//  ButtonWithBiggerArea.swift
//  kurs.kz
//
//  Created by MacBook on 20.09.2023.
//

import UIKit

final class ButtonWithBiggerArea: UIButton {

    // MARK: - Functions

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7)).contains(point)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
