//
//  CoordinatorProtocol.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 30.05.2024.
//

import UIKit

//protocol Coordinator {
//    
//    var navigationController: UINavigationController? { get set }
//    var childCoordinator: [Coordinator] { get set }
//    
//    func start()
//}
//
//protocol Coordinating {
//    var coordinator: Coordinator? { get set }
//}



protocol CoordinatorProtocol: AnyObject {
    func start() -> UIViewController
}
