//
//  KeychainStore.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 04.06.2024.
//

import UIKit
import KeychainSwift

final class KeychainStore: KeychainServiceProtocol {
    
    let keychain = KeychainSwift()
    var name: String {
        "Keychain"
    }
    
    func load() -> [KeychainService] {
        //        if let data = KeychainSwift().getData("database ") {
        //        return  (try? JSONDecoder().decode([KeychainService].self, from: data)) ?? []
        
        if let password = keychain.getData("myPassword") {
            print("Пароль: \(password)")
            return decode(data: password)
        } else {
            return []
        }
    }
    
    func save(items: [KeychainService]) {
        //        if let data = try? JSONEncoder().encode(items) {
        //            KeychainSwift().set(data, forKey: "database")
        
        if (try? JSONEncoder().encode(items)) != nil {
        keychain.set("password123", forKey: "myPassword")
        }
    }
    func update() {
    }
}
