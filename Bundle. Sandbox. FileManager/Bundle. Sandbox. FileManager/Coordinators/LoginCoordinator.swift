////  LoginCoordinator.swift
////  Bundle. Sandbox. FileManager
//
////Created by Юлия Кагирова on 30.05.2024.
//
//
import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func pushLoginButton()
}

final class LoginCoordinator {
    
    // MARK: - Properties
    weak var parentCoordinator: MainCoordinatorProtocol?
    var navigationController: UINavigationController
    init(parentCoordinator: MainCoordinatorProtocol?, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        return loginVC
    }
}

// MARK: - CoordinatorProtocol
extension LoginCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

// MARK: - LoginCoordinatorProtocol
extension LoginCoordinator: LoginCoordinatorProtocol {
    func pushLoginButton() {
        parentCoordinator?.didTapLogin()
    }
}

