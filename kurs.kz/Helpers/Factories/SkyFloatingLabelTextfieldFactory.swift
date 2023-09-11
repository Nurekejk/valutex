//
//  SkyFloatingLabelTextfieldFactory.swift
//  kurs.kz
//
//  Created by MacBook on 11.09.2023.
//

import Foundation
import SkyFloatingLabelTextField

public protocol TextfieldFactory: AnyObject {
    func getPasswordTextfield(with placeholder: String) -> PasswordTextField
    func getRepeatPasswordTextfield() -> PasswordTextField
    func getTextfield(with placeholder: String) -> SkyFloatingLabelTextField
}

public class SkyFloatingLabelTextfieldFactory: NSObject, TextfieldFactory {
    
    public func getPasswordTextfield(with placeholder: String = "") -> PasswordTextField {
        let textfield = PasswordTextField(isRepeatPassword: false)
        if placeholder != "" {
            textfield.placeholder = placeholder
        }
        return textfield

    }
    
    public func getRepeatPasswordTextfield() -> PasswordTextField {
        PasswordTextField(isRepeatPassword: true)
    }
    
    public func getTextfield(with placeholder: String = "") -> SkyFloatingLabelTextField {
        let textfield = PaddedTextField()
        if placeholder != "" {
            textfield.placeholder = placeholder
        }
        return textfield
    }
}
