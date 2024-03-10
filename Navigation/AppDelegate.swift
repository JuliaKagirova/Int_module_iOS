//
//  AppDelegate.swift
//  Navigation
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? 
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // create tab bar with feed and profile items
        let loginVC = LoginViewController()
        let loginInspector = MyLoginFactory().makeLoginInspector()
        loginVC.loginDelegate = loginInspector
        
        let model = FeedModel()
        let viewModel = FeedViewModel(model: model)
        let fVC = FeedViewController(viewModel: viewModel)

        let feedNC = UINavigationController(rootViewController: fVC)
        feedNC.tabBarItem = UITabBarItem(title: "Feed",
                                         image: UIImage(systemName: "text.bubble"),
                                         selectedImage: UIImage(systemName: "text.bubble.fill"))

        let profileNC = UINavigationController(rootViewController: loginVC)
        profileNC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person.crop.circle"),
                                            selectedImage: UIImage(systemName: "person.crop.circle.fill"))
      
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .placeholderText
        tabBarController.viewControllers = [ profileNC, feedNC ]
        
        // activate main window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
        let coordinator = MainCoordinator()
        coordinator.start()
        return true
    } 
}

