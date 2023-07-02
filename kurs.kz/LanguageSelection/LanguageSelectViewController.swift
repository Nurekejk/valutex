//
//  LanguageSelectViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 2/7/23.
//

import UIKit
import SnapKit

class LanguageSelectViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "selectlanguage")
        return imageView
    }()
    
}
