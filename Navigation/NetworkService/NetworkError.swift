//
//  NetworkError.swift
//  Navigation
//
//  Created by Юлия Кагирова on 23.04.2024.
//

import Foundation

enum NetworkError: Error {
    case custom(description: String)
    case server
    case unknown
}
