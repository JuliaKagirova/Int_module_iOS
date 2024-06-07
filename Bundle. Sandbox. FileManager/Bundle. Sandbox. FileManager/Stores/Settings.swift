//
//  Settings.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 04.06.2024.
//

import UIKit

final class Settings {
    static let shared = Settings()
    
    var currentStoreIndex: Int {
        get {
            UserDefaults.standard.integer(forKey: "currentStoreIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentStoreIndex")
        }
    }
    var stores: [KeychainServiceProtocol] = [UserDefaultsStore(), KeychainStore()]
    
    var curretStore: KeychainServiceProtocol {
        stores[currentStoreIndex]
    }
}
