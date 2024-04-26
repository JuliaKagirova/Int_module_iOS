//
//  Time.swift
//  Navigation
//
//  Created by Юлия Кагирова on 22.04.2024.
//

import Foundation

struct Time: Decodable {
        let name: String?
        let orbitalPeriod: String?
    
    enum CodingKeys: String ,CodingKey {
        
        case name
        case orbitalPeriod = "orbitalPeriod"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
    }  
}
