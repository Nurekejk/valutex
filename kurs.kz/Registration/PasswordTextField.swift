//
//  PasswordTextField.swift
//  kurs.kz
//
//  Created by MacBook on 04.07.2023.
//

import UIKit

final class PasswordTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding = 16.0
        let iconWidth = 24.0
        let iconHeight = 24.0
        let middlePointAdjuster = (bounds.height - iconHeight) / 2.0
        let rightBounds = CGRect(x: bounds.width - iconWidth - padding, y: middlePointAdjuster, width: iconWidth, height: iconHeight)
            return rightBounds
    }
}
