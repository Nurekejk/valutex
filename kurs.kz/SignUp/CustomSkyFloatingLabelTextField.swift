//
//  CustomSkyFloatingLabelTextField.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 04.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

class CustomSkyFloatingLabelTextField: SkyFloatingLabelTextField {
    
        let padding = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
        override open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
            if editing {
                return CGRect(x: 16, y: 8, width: bounds.size.width, height: titleHeight())
            }
            return CGRect(x: 100, y: titleHeight(), width: bounds.size.width, height: titleHeight())
        }

}
