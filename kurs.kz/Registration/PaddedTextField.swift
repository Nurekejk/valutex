//
//  PaddedTextField.swift
//  kurs.kz
//
//  Created by MacBook on 04.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

class PaddedTextField: SkyFloatingLabelTextField {

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
    override open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 5, y: 5, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 100, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
}
