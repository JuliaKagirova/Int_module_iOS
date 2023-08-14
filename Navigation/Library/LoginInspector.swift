//
//  LoginInspector.swift
//  Navigation
//
//  Created by Юлия Кагирова on 14.08.2023.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}
