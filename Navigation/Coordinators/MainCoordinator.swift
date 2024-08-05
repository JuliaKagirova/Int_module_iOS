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

        let profileVC = ProfileViewController()
        profileVC.coordinator = self
        
        let model = FeedModel()
        let viewModel = FeedViewModel(model: model)
        let feedVC = FeedViewController(viewModel: viewModel)
        feedVC.coordinator = self
        
        let photosVC = PhotosViewController()
        photosVC.coordinator = self
        
        let favourites = LikePostViewController()
//        favourites.coordinator = self
        
        
        navigationController?.setViewControllers([favourites, photosVC, feedVC, profileVC],
                                                 animated: false)
    }
}
