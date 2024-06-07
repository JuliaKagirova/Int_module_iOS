//
//  DocumentsCoordinator.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 04.06.2024.

import UIKit

protocol DocumentsCoordinatorProtocol {
    func pushAddNewFolder()
    func pushAddNewPhoto()
}

final class DocumentsCoordinator {
    
    // MARK: - Private Properties
    
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    private var childCoordinators: [CoordinatorProtocol] = []
    private var rootViewController: UIViewController?
    private var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    
    init(parentCoordinator: TabBarCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    // MARK: - Methods
    
     func createNavigationController() -> UIViewController {
        let docVC = DocumentsViewController()
        rootViewController = docVC
         
        let navigationController = UINavigationController(rootViewController: docVC)
        navigationController.tabBarItem = UITabBarItem(title: "Documents",
                                                       image: UIImage(systemName: "list.bullet"),
                                                       tag: 1)
        self.navigationController =  navigationController
        return navigationController
    }
}

// MARK: - CoordinatorProtocol

extension DocumentsCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

// MARK: - ProfileCoordinatorDelegate

extension DocumentsCoordinator: DocumentsCoordinatorProtocol {
    
    func pushAddNewFolder() {
    }
    
    func pushAddNewPhoto() {
    }
}

