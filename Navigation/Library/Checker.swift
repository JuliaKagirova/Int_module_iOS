//
//  Checker.swift
//  Navigation
//
//  Created by Юлия Кагирова on 11.08.2023.
//

import UIKit

class Checker {
    static let shared = Checker(login: "testDebug", password: "debug")
    var login = String()
    var password = String()
    
    private init (login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    func check(login: String, password: String) -> Bool {
        if login == "testDebug" {
        } else if  password == "debug" {
        }
        return true
    }
}
