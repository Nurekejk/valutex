//
//  ExchangesMapViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 30.07.2023.
//

import UIKit
import Pulley

final class ExchangesMapViewController: PulleyViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self.primaryContentViewController as? any PulleyDelegate
    }
}
