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
    
    func  fetchLikePost() -> [LikePost ] {
        let request = LikePost.fetchRequest()
       return (try? persistentContainer.viewContext.fetch(request)) ?? []
    }
    
    func addLikePost(title: String) {
        let likePost = LikePost(context: persistentContainer.viewContext)
        likePost.name = title
        likePost.dateCreated = Date()
        try? persistentContainer.viewContext.save()
    }
    
    func deleteLikePost(likePost: LikePost) {
        let context = likePost.managedObjectContext
        context?.delete(likePost)
        try? context?.save()
    }
}
