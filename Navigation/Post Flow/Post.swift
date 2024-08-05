//
//  Post.swift
//  Navigation
//

import UIKit

public struct Post {
    
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int32
    public let views: Int32
    public let id: String
     
    public init(author: String, description: String, image: String, likes: Int32, views: Int32, id: String) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views  
        self.id = id
    }

}

