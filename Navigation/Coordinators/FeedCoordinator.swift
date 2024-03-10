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



