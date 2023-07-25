//
//  PasswordTextField.swift
//  kurs.kz
//
//  Created by MacBook on 04.07.2023.
//

import UIKit

final class PasswordTextField: UITextField {
    
    let rightViewWidth: CGFloat = 24.0
    let rightViewHeight: CGFloat = 24.0
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding: CGFloat = 16.0
        let middlePointAdjuster = (bounds.height - rightViewHeight) / 2.0
        let rightBounds = CGRect(x: bounds.width - rightViewWidth - padding,
                                 y: middlePointAdjuster,
                                 width: rightViewWidth,
                                 height: rightViewHeight)
            return rightBounds
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let trimValue: CGFloat = 30
        return CGRect(x: 10, y: 0, width: bounds.width - rightViewWidth - trimValue, height: bounds.height)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let trimValue: CGFloat = 30
        return CGRect(x: 10, y: 0, width: bounds.width - rightViewWidth - trimValue, height: bounds.height)
    }
}
