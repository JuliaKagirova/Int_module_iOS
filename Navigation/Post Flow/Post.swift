//
//  Post.swift
//  Navigation
//

import UIKit

public struct Post {
    
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int16
    public let views: Double
    public let id: UUID
     
    public init(author: String, description: String, image: String, likes: Int16, views: Double, id: UUID) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views  
        self.id = id
    }

}

