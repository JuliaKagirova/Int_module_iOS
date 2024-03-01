//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Юлия Кагирова on 29.02.2024.
//


import UIKit

protocol Coordinator{
    
//    let profileNavigationController: UINavigationController
//    let feedNavigationController: UINavigationController
//    
//    init(profileNavigationController: UINavigationController, feedNavigationController: UINavigationController) {
//        self.profileNavigationController = profileNavigationController
//        self.feedNavigationController = feedNavigationController
//    }
//    
//    func start() {
//        let model = FeedModel()
//        let viewModel = FeedViewModel(model: model)
//        profileNavigationController.pushViewController(ProfileViewController(), animated: false)
//        feedNavigationController.pushViewController(FeedViewController(viewModel: viewModel), animated: false)
//    }
//    
    
    
    var parentCoordinator: Coordinator? { get set }
       var children: [Coordinator] { get set }
       var navigationController: UINavigationController { get set }
       
       func start()
}
