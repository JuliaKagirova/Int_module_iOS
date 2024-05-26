//
//  Time.swift
//  Navigation
//
//  Created by Юлия Кагирова on 22.04.2024.
//

import Foundation

struct Time: Decodable {
    let name: String?
    var orbitalPeriod: String
    
    enum CodingKeys: String ,CodingKey {
        case name
        case orbitalPeriod = "orbitalPeriod"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
        
//        if let key = try container.decodeIfPresent (Int.self, forKey: .orbitalPeriod) {
//            self .orbitalPeriod = key
//        } else if let key = try container.decodeIfPresent(String.self, forKey: .orbitalPeriod) {
//            self .orbitalPeriod = Int(key) ?? 0
//        } else {
//            self.orbitalPeriod = 0
//        }
    }
}
