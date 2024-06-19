//
//  Coordinator.swift
//  Navigation
//
//  Created by Юлия Кагирова on 29.02.2024.
//


import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController? { get set }
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

//protocol Coordinating {
//    var coordinator: Coordinator? { get set }
//}
