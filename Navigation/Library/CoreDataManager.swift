//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 03.07.2024.
//

import Foundation
import CoreData
final class CoreDataManager {
    
    static var shared  = CoreDataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func  fetchLikePost() -> [LikePost] {
        let request = LikePost.fetchRequest()
       return (try? persistentContainer.viewContext.fetch(request)) ?? []
    }
    
//    func addLikePost(likes: Int16, views: Int16, descriptionName: String, postAuthor: String) {
//        let likePost = LikePost(context: persistentContainer.viewContext)
//        likePost.descriptionName = descriptionName
//        likePost.likes = likes
//        likePost.postAuthor = postAuthor
//        likePost.views = views
//        likePost.dateCreated = Date()
//        try? persistentContainer.viewContext.save()
//    }
//    
//    
    func addLikePost(post: Post) {
        let likePost = LikePost(context: persistentContainer.viewContext)
        likePost.descriptionName = post.description
        likePost.likes = post.likes
        likePost.postAuthor = post.author
        likePost.views = post.views
        likePost.image = post.image
        likePost.id = post.id
        likePost.dateCreated = Date()
        try? persistentContainer.viewContext.save()
    }
    
    
    func addLikePost2() {
        let likePost = LikePost(context: persistentContainer.viewContext)
//        likePost.descriptionName = post.description
//        likePost.likes = post.likes
//        likePost.postAuthor = post.author
//        likePost.views = post.views
//        likePost.image = post.image
//        likePost.id = post.id

        likePost.dateCreated = Date()
        try? persistentContainer.viewContext.save()
    }
    
    func addLikePost3(_ post: Post) {
        var likePost = LikePost(context: persistentContainer.viewContext)
        let newPost = Post(author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views, id: post.id)
        try? persistentContainer.viewContext.save()
    }
    
    func deleteLikePost(likePost: LikePost) {
        let context = likePost.managedObjectContext
        context?.delete(likePost)
        try? context?.save()
    }
//    
//    func findDuplicate(postId: Post) {
//        let duplicate = LikePost(context: persistentContainer.viewContext)
//        let newDuplicate = postId
//        
//    }
    
//    func findDuplicate(post: Post) {
//        var likePost = LikePost(context: persistentContainer.viewContext)
//        if likePost.id == post.id {
//            deleteLikePost(likePost: )
//        }
//    }
}
