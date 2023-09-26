//
//  PhotoExamples.swift
//  Navigation
//

import UIKit

final class Photos {
    
    static let shared = Photos()
    let examples: [UIImage] 
    
    private init() {
<<<<<<< HEAD
        var photos = [UIImage]() 
        for i in 1...20 { photos.append((UIImage(named: "\(i)") ?? UIImage())) }
=======
        var photos = [UIImage]()
        for i in 1...20 { photos.append((UIImage(named: "\(i)") ?? UIImage() )) }
>>>>>>> feature/task
        examples = photos.shuffled()
    } 
}

