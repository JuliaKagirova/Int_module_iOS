//
//  MainCoordinator.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 30.05.2024.
//

import UIKit
import KeychainSwift

protocol MainCoordinatorProtocol: AnyObject {
    func didTapLogin()
}

final class MainCoordinator {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var tabBarController = UITabBarController()
    var navigationController: UINavigationController
    
    // MARK: - Life Cycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Private methods
    
    func setLoginVC()  {
        let loginCoordinator = LoginCoordinator(parentCoordinator: self, navigationController: navigationController)
        let vc = loginCoordinator.start()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func setTabBarVC() {
        let tabBarCoordinator = TabBarCoordinator(parentCoordinator: self, tabBarController: tabBarController)
         let vc =  tabBarCoordinator.start()
        navigationController.setViewControllers([vc], animated: true)
    }
}

// MARK: - CoordinatorProtocol

extension MainCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {

        if passwordIsSavedInKeychain() {
            setTabBarVC()
            return navigationController
        } else {
            setLoginVC()
            return navigationController
        }
    }
    
    func passwordIsSavedInKeychain() -> Bool {
        let keychain = KeychainSwift()
        let passwordResult = keychain.get("pass2")
        print("Password: \(String(describing: passwordResult))")
        return passwordResult != nil
    }
  
    func presentSavePasswordAlert() {
        let alert = UIAlertController(title: "Сохранить пароль", message: "Чтобы продолжить, сохраните пароль в keychain.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { _ in
            self.savePassword()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        let scene = UIApplication.shared.connectedScenes.first
        let window = scene?.inputView?.window?.windowScene?.keyWindow
        let rootViewController = window?.rootViewController
        
        rootViewController?.present(alert, animated: true)
    }
    
    func savePassword() {
        let keychain = KeychainSwift()
        keychain.set("password", forKey: "pass2")
    }
    
    func loginButtonTapped() {
        let docVC = DocumentsViewController()
        docVC.mainCoordinator = self
        UINavigationController().navigationController?.pushViewController(docVC, animated: true)
    }
    func switchFlow() {
        if passwordIsSavedInKeychain() {
            setTabBarVC()
        }
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func didTapLogin() {
        savePassword()
        switchFlow()
    }
    
    
}
