//
//  OfferSkyFloatingLabelTextField.swift
//  kurs.kz
//
//  Created by Nurbol on 21.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

final class OfferSkyFloatingLabelTextField: SkyFloatingLabelTextField {

    let padding = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 192)
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding: CGFloat = 16.0
        let rightViewWidth: CGFloat = 69.0
        let rightViewHeight: CGFloat = 24.0
        let middlePointAdjuster = (bounds.height - rightViewHeight) / 2.0
        let rightBounds = CGRect(x: bounds.width - rightViewWidth - padding,
                                 y: middlePointAdjuster,
                                 width: rightViewWidth,
                                 height: rightViewHeight)
        return rightBounds
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 16, y: 8, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 100, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
}
