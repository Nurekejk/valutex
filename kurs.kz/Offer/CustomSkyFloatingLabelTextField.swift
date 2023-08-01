//
//  CustomSkyFloatingLabelTextField.swift
//  kurs.kz
//
//  Created by Nurbol on 19.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

final class OfferSkyFloatingLabelTextField: SkyFloatingLabelTextField {

        let padding = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)

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
