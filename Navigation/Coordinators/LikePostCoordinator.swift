//
//  LikePostCoordinator.swift
//  Navigation
//
//  Created by Юлия Кагирова on 26.07.2024.
//

import UIKit


//MARK: - protocol

protocol PostLikeCoordinatorProtocol:AnyObject {
    var navigationController: UINavigationController? {get set}
    func showDetail()
    func pop()
}

//MARK: - class
class LikePostCoordinator:PostLikeCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    //MARK: - Method
    func showDetail() {
        let postVC = UIViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    //MARK: - Proportis
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}


//
//import UIKit
//import CoreData
//
//final class LikePostCoordinator: Coordinator {
//    
//    var navigationController: UINavigationController?
//    var childCoordinator = [Coordinator]()
//
//    var currentPost: Post?
//    
//        init(navigationController: UINavigationController) {
//            self.navigationController = navigationController
//        }
//        
//    func start() {
//        let profileViewController = ProfileViewController()
//        navigationController?.setViewControllers([profileViewController], animated: true)
//    }
//    func showPhotosVC() {
//        let photosVC = PhotosViewController()
//        navigationController?.setViewControllers([photosVC], animated: true)
//    }
//    
//}
