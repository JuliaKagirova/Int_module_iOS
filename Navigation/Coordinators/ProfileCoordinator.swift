//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Юлия Кагирова on 29.02.2024.
//

import UIKit
import CoreData

final class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var childCoordinator = [Coordinator]()

    var currentPost: Post?
    
        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
        
    func start() {
        let profileViewController = ProfileViewController()
        navigationController?.setViewControllers([profileViewController], animated: true)
    }
    func showPhotosVC() {
        let photosVC = PhotosViewController()
        navigationController?.setViewControllers([photosVC], animated: true)
    }
}
