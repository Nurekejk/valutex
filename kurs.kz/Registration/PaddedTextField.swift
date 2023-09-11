//
//  PaddedTextField.swift
//  kurs.kz
//
//  Created by MacBook on 04.07.2023.
//

import UIKit
import SkyFloatingLabelTextField

public class PaddedTextField: SkyFloatingLabelTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextField() {
        self.placeholderColor = AppColor.gray50.uiColor
        self.placeholderFont = AppFont.regular.s16()

        self.titleColor = UIColor.lightGray
        self.titleLabel.font = AppFont.regular.s12()
        self.selectedTitleColor = AppColor.gray50.uiColor
        self.textColor = AppColor.gray100.uiColor
        self.titleFormatter = { $0 }
        self.keyboardType = .default
        self.lineView.isHidden = true
    }
    
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
