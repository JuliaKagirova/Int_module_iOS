//
//  UserDefaultsStore.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 04.06.2024.
//

import Foundation
 
final class UserDefaultsStore: KeychainServiceProtocol {
    var name: String {
        "User Defaults"
    }
    
    func load() -> [KeychainService] {
        if let data = UserDefaults.standard.data(forKey: "database") {
          return  (try? JSONDecoder().decode([KeychainService].self, from: data)) ?? []
        } else {
            return []
        }
    }
    
    func save(items: [KeychainService]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: "database")

        }
    }
    
    func update() {
        
    }
    
     
}
