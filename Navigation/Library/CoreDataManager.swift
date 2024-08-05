//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 03.07.2024.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static var shared  = CoreDataManager()
    
    var likePosts: [LikePost] {
        fetchLikePost()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchLikePost() -> [LikePost] {
        let request = LikePost.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteLikePost(likePost: LikePost) {
        let context = likePost.managedObjectContext
        context?.delete(likePost)
        try? context?.save()
    }
    
    private func getPost(likePost: Post) -> LikePost? {
        let request = LikePost.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", likePost.id)
        return (try? context.fetch(request))?.first
    }

    func addLikePost(postOrigin: Post) {
        guard getPost(likePost: postOrigin) == nil else { return }
        let post = LikePost(context: context)
        post.postAuthor = postOrigin.author
        post.image = postOrigin.image
        post.descriptionName = postOrigin.description
        post.likes = Int32(postOrigin.likes)
        post.views = Int32(postOrigin.views)
        post.id = postOrigin.id
        post.dateCreated = Date()
        try? context.save()
    }
}
