//
//  TabBarCoordinator.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 05.06.2024.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func pushDocumentVC()
    func pushSettingsVC()
}

final class TabBarCoordinator {
    
    //MARK: - Private properties
    
    private weak var parentCoordinator: MainCoordinatorProtocol?
    private var tabBarController: UITabBarController
    private var childCoordinators: [CoordinatorProtocol] = []
    
    // MARK: - Life Cycle
    
    init(parentCoordinator: MainCoordinatorProtocol, tabBarController: UITabBarController) {
        self.parentCoordinator = parentCoordinator
        self.tabBarController = tabBarController
    }
    
    // MARK: - Private methods
    private func createTabBar() -> UIViewController {
        
        let tabBarController = UITabBarController()
        
        let docCoordinator = DocumentsCoordinator(parentCoordinator: self)
        let setCoordinator = SettingsCoordinator(parentCoordinator: self)
        addChildCoordinator(docCoordinator)
        addChildCoordinator(setCoordinator)
        
        let controllers =
        [
            docCoordinator.start(),
            setCoordinator.start()
        ]
        
        tabBarController.viewControllers = controllers
        tabBarController.tabBar.tintColor = .systemRed
        tabBarController.tabBar.unselectedItemTintColor = .black
        self.tabBarController = tabBarController
        return tabBarController
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
}

// MARK: - CoordinatorProtocol

extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createTabBar()
    }
}

// MARK: - TabBarCoordinatorProtocol

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    
    func pushDocumentVC() {
        
    }
    func pushSettingsVC() {
        
    }
}
