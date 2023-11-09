//  Checker.swift
//  Navigation
//
//  Created by Юлия Кагирова on 11.08.2023.

import UIKit

class Checker {
    static let shared = Checker(login:"testDebug", password:"debug")
    
    //Mark: - Properties
    
    let login: String
    let password: String
    
    //Mark: - Init
    
    private init (login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    //Mark: - Methods
    
    func check(login: String, password: String) -> Bool {
            login == self.login && password == self.password
        }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
} 

