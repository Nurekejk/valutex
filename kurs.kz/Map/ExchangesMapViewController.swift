//
//  ExchangesMapViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 30.07.2023.
//

import UIKit
import Pulley

class ExchangesMapViewController: PulleyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self.primaryContentViewController as? any PulleyDelegate
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
