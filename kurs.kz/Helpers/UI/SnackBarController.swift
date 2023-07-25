//
//  SnackBarController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 23.07.2023.
//

import UIKit
import SnackBar_swift

final class SnackBarController: SnackBar {

    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = AppColor.gray10.uiColor
        style.textColor = AppColor.gray100.uiColor
        return style
    }

    static func showSnackBar(in view: UIView, message: String, duration: Duration) {
        let snackBar = SnackBarController.make(in: view, message: message, duration: duration)
        snackBar.show()
    }

}
