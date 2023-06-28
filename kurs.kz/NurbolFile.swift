//
//  NurbolFile.swift
//  kurs.kz
//
//  Created by Nurbol on 27.06.2023.
//

import Foundation

struct Person {
    var name: String
    var age: Int

    func introduce() {
        print("Меня зовут \(name) и мне \(age) лет.")
    }
}

var person1 = Person(name: "Нурбол", age: 19)
