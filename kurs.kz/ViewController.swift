//
//  ViewController.swift
//  kurs.kz
//
//  Created by Islam on 27.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    struct MyStruct {
        let name: String
        let age: Int
        // здесь я создаю структуру
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // здесь будут доп настройки
        
    }
    
    //this method does nothing:
    func adilMethod() {

    }
}

class MyTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // здесь тоже будут доп настройки для контроллера
    }
}

