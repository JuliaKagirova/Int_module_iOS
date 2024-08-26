//
//  Password.swift
//  Navigation
//
//  Created by Юлия Кагирова on 26.08.2024.
//

import Foundation

//dataBase login/pass
//567

class SecurityManager {
    
}

var newKey = {
    return "abcd123"
}()

let criptoKey: [UInt8] = [100, 50, 25, 99, 30, 67]

let key = "abcd1jjjj23"

func makeKey(key: String) -> [UInt8] {
    var byte = [UInt8]()
    for b in key.data(using: .utf8) ?? Data() {
        byte.append(b)
    }
    return byte
}

func keyFromUint(array: [UInt8]) -> String? {
    return String(bytes: array, encoding: .utf8)
}
