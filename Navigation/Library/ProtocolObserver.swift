//
//  ProtocolObserver.swift
//  Navigation
//
//  Created by Юлия Кагирова on 25.10.2023.
//

import Foundation

protocol Subscriber: AnyObject {
    func update(photos: [Photos]) 
}
