//
//  KeychainServiceProtocol.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 30.05.2024.
//

import UIKit

protocol KeychainServiceProtocol {
    var name: String { get }
    func load() -> [KeychainService]
    func save(items: [KeychainService])
    func update()
}

struct KeychainService: Codable {
    var title: String
    var isCompleted: Bool
    var date: Date
    
    init(title: String) {
        self.title = title
        self.isCompleted = false
        self.date = Date()
    }
}
extension KeychainServiceProtocol {
    func encode(items: [KeychainService]) -> Data? {
        try? JSONEncoder().encode(items)
    }
    
    func decode(data: Data) -> [KeychainService] {
        return (try? JSONDecoder().decode([KeychainService].self, from: data)) ?? []
    }
}
