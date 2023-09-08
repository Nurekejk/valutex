//
//  PasswordTextField.swift
//  kurs.kz
//
//  Created by MacBook on 04.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

final class PasswordTextField: SkyFloatingLabelTextField {
    
    let rightViewWidth: CGFloat = 24.0
    let rightViewHeight: CGFloat = 24.0
    let trimValue: CGFloat = 30
    
    let button = ShowHideTextButton()
    
    var buttonIsSelected = false {
        didSet {
            button.isSelected = buttonIsSelected
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.rightView = button
        self.rightViewMode = .always
    }
    
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

        return CGRect(x: 10, y: 0, width: bounds.width - rightViewWidth - trimValue, height: bounds.height)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 0, width: bounds.width - rightViewWidth - trimValue, height: bounds.height)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: rightViewWidth + trimValue))
    }
}
