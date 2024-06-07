//  SettingsCoordinator.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 03.06.2024.
//

import UIKit

protocol SettingsCoordinatorProtocol: AnyObject {
    func pushSizeSwicth()
    func pushSortSwicth()
    func pushChangePassButton()
    func pushAddSetting()
}

final class SettingsCoordinator {
    
    // MARK: - Private Properties
    
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    private var childCoordinators: [CoordinatorProtocol] = []
    private var rootViewController: UIViewController?
    private var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    
    init(parentCoordinator: TabBarCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    // MARK: - Private methods
    
    private func createNavigationController() -> UIViewController {
        let setVC = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: setVC)
        navigationController.tabBarItem = UITabBarItem(title: "Настройки",
                                                       image: UIImage(systemName: "gear.badge"),
                                                       tag: 0)
        self.navigationController =  navigationController
        return navigationController
    }
}

// MARK: - CoordinatorProtocol

extension SettingsCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

// MARK: - ProfileCoordinatorDelegate

extension SettingsCoordinator: SettingsCoordinatorProtocol {
    func pushSizeSwicth() {
    }
    
    func pushSortSwicth() {
    }
    
    func pushChangePassButton() {
    }
    
    func pushAddSetting() {
    }
}
