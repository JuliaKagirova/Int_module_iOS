//
//  ProtocolObserver.swift
//  Navigation
//
//  Created by Юлия Кагирова on 17.11.2023.
//

import UIKit

protocol Subscriber: AnyObject {
    func update(photos: [Photos])
}
