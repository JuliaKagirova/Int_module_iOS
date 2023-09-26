//
//  LoginFactory.swift
//  Navigation
//
//  Created by Юлия Кагирова on 25.08.2023.
//

import UIKit

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        .init()
    }
}
