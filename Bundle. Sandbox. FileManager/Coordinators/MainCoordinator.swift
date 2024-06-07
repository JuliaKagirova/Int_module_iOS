//
//  MainCoordinator.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 30.05.2024.
//

//import UIKit
//
//final class MainCoordinator: Coordinator {
//    
//    var childCoordinator = [Coordinator]()
//    var navigationController: UINavigationController?
//    var tabBarController = UITabBarController()
//    var coordinator: [Coordinator]?  = nil
//    
//    func start() {
//
//        var loginVC: UIViewController & Coordinating = LoginViewController()
//        loginVC.coordinator = self
//
//        var docVC: UIViewController & Coordinating = DocumentsViewController()
//        docVC.coordinator = self
//        
//        var settingsVC: UIViewController & Coordinating = SettingsViewController()
//        settingsVC.coordinator = self
//        
//        navigationController?.setViewControllers([ settingsVC, docVC, loginVC],
//                                                 animated: false)
//    }
//    private func tabBarCoordinator() -> Coordinator {
//        let tabBarCoordinator = TabBarCoordinator(parentCoordinator: self, tabBarController: tabBarController)
//        return tabBarCoordinator
//    }
//}



import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func switchToNextBranch(from coordinator: CoordinatorProtocol)
}

final class AppCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [CoordinatorProtocol] = []
    var tabBarController = UITabBarController()
    
    // MARK: - Private properties
    private var rootViewController: UIViewController
    
    private func loginCoordinator() -> CoordinatorProtocol {
        let loginCoordinator = LoginCoordinator(parentCoordinator: self)
        return loginCoordinator
    }
    
    private func tabBarCoordinator() -> CoordinatorProtocol {
        let tabBarCoordinator = TabBarCoordinator(parentCoordinator: self, tabBarController: tabBarController)
        return tabBarCoordinator
    }
    
    // MARK: - Life Cycle
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Private methods
    
    private func showTabBarOnMainScreen(for user: User?) -> UIViewController {
        let coordinator = tabBarCoordinator()
        addChildCoordinator(coordinator)
        setFlow(to: coordinator.start())
        return rootViewController
    }
    
    private func setFlow(to newViewController: UIViewController) {
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: rootViewController)
    }
    
    private func switchCoordinators(from previousCoordinator: CoordinatorProtocol, to nextCoordinator: CoordinatorProtocol) {
        addChildCoordinator(nextCoordinator)
        switchFlow(to: nextCoordinator.start())
        removeChildCoordinator(previousCoordinator)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        guard let currentViewController = rootViewController.children.first else {
            return
        }
        
        currentViewController.willMove(toParent: nil)
        currentViewController.navigationController?.isNavigationBarHidden = true
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.bounds
        
        rootViewController.transition(
            from: rootViewController.children[0],
            to: newViewController,
            duration: 0.5,
            options: [.transitionFlipFromRight]
        ) { [weak self] in
            guard let self else { return }
            currentViewController.removeFromParent()
            newViewController.didMove(toParent: rootViewController)
        }
    }
    
    private func isFirstLaunch() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isFirstLaunch")
    }
        
    private func markAppAsLaunched() {
        UserDefaults.standard.set(true, forKey: "isFirstLaunch")
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

// MARK: - CoordinatorProtocol
extension AppCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        if isFirstLaunch() {
//            showOnboarding()
//        } else {
            showTabBarOnMainScreen(for: nil)
        }
    }
}

// MARK: - AppCoordinatorProtocol
extension AppCoordinator: AppCoordinatorProtocol {
    func switchToNextBranch(from coordinator: CoordinatorProtocol) {
        
        switch coordinator {
//        case let coordinator as OnboardingCoordinator:
//            switchCoordinators(from: coordinator, to: authorizationCoordinator())
        case let coordinator as AuthorizationCoordinator:
            markAppAsLaunched()
            switchCoordinators(from: coordinator, to: tabBarCoordinator())
        default:
            print("Error coordinators switching")
        }
    }
}

