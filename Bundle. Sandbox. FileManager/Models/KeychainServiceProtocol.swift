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
    func save(password: [KeychainService])
    func update()

}

struct KeychainService: Codable    {
    let title: String
    var isCompleted: Bool
    var date: Date
    
    init(title: String) {
        self.title = title
        self.isCompleted = false
        self.date = Date()
    }
}
