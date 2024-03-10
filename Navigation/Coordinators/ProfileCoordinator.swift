//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Юлия Кагирова on 29.02.2024.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var childCoordinator = [Coordinator]()

        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
        
        func start() {
            let profileViewController = ProfileViewController()
            navigationController?.setViewControllers([profileViewController], animated: true)
        }
}
