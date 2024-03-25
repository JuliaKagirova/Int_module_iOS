//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Юлия Кагирова on 29.02.2024.
//

import UIKit

final class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var childCoordinator = [Coordinator]()
    
    init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
    
    func start() {
        var postVC: UIViewController & Coordinating = PostViewController()
        postVC.coordinator = self
        
        var infoVC: UIViewController & Coordinating = InfoViewController()
        infoVC.coordinator = self
        
        navigationController?.setViewControllers([postVC, infoVC], animated: true)
    }
}

//var 2

//final class FeedCoordinator: Coordinator {
//    var controller: UIViewController
//    
//    var children: [Coordinator]
//    
//    let feedVC = FeedViewController()
//    let feedNC: UINavigationController
//    
//    enum Presentation {
//        case post
//        case info
//    }
//    
//    init() {
//        children = []
//                
//        feedNC = UINavigationController(rootViewController: feedVC)
//        feedNC.tabBarItem = UITabBarItem(title: "Feed",
//                                         image: UIImage(systemName: "text.bubble"),
//                                         selectedImage: UIImage(systemName: "text.bubble.fill"))
//        controller = feedNC
//    }
//    
//    func setup() {
//        feedVC.coordinator = self
//    }
//    
//    func present(_ presentation: Presentation) {
//        switch presentation {
//        case .post:
//            let post = postExamples[0]
//            
//            let postVC = PostViewController()
//            postVC.coordinator = self
//            postVC.post = post
//            feedNC.pushViewController(postVC, animated: true)
//        case .info:
//            let infoVC = InfoViewController()
//            feedNC.present(infoVC, animated: true, completion: nil)
//        }
//    }
//}
