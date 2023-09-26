//
//  Checker.swift
//  Navigation
//
//  Created by Юлия Кагирова on 11.08.2023.
//

import UIKit

class Checker {
    static let shared = Checker(login: "testDebug", password: "debug")
    let login: String
    let password: String
    
    private init (login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    func check(login: String, password: String) -> Bool {
            login == self.login && password == self.password
        }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
} 

