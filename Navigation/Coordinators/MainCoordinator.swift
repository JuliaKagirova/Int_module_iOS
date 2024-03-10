//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Юлия Кагирова on 01.03.2024.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController?
    var coordinator: [Coordinator]?  = nil
    
    func start() {

        var profileVC: UIViewController & Coordinating = ProfileViewController()
        profileVC.coordinator = self
        
        let model = FeedModel()
        let viewModel = FeedViewModel(model: model)
        var feedVC: UIViewController & Coordinating = FeedViewController(viewModel: viewModel)
        feedVC.coordinator = self
        
        navigationController?.setViewControllers([feedVC, profileVC],
                                                 animated: false)
    }
}
