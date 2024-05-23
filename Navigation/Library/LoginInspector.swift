//  LoginInspector.swift
//  Navigation
//
//  Created by Юлия Кагирова on 14.08.2023.

import UIKit
import Firebase

struct LoginInspector: LoginViewControllerDelegate {
    func signUp() {
    }
    
    func checkCredentials(mail: String, password: String) -> Bool {
        return Checker.shared.check(login: mail, password: password)
    }
}

