//DocumentsCoordinator.swift
//  Bundle. Sandbox. FileManager

//Created by Юлия Кагирова on 30.05.2024.


import UIKit

final class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var childCoordinator = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC: UIViewController & Coordinating = LoginViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
 
    func loginbuttonTapped() {
        let docVC: UIViewController & Coordinating = DocumentsViewController()
        navigationController?.setViewControllers([docVC], animated: true)
    }
}
