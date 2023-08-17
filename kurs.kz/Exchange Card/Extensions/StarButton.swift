//
//  StarButton.swift
//  kurs.kz
//
//  Created by MacBook on 06.07.2023.
//

import UIKit

final class StarButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    func setupButton() {
        setImage(AppImage.gray_star.uiImage, for: .normal)
        setImage(AppImage.golden_star.uiImage, for: .selected)
        imageView?.contentMode = .scaleToFill
    }
}
