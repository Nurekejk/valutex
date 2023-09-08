//
//  showHideTextButton.swift
//  kurs.kz
//
//  Created by MacBook on 04.07.2023.
//

import UIKit

final class ShowHideTextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setImage(AppImage.eye_slash.uiImage, for: .normal)
        setImage(AppImage.eye.uiImage?.withTintColor(AppColor.gray50.uiColor), for: .selected)
    }
}
