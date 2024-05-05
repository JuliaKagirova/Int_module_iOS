//
//  PostViewController.swift
//  Navigation
//

import UIKit
import StorageService
 
 final class PostViewController: UIViewController, Coordinating {
     
    //MARK: - Properties
     
     var post: Post?
     var coordinator: Coordinator?

     
     //MARK: - Life Cycle

      override func viewDidLoad() {
        super.viewDidLoad() 
        title = post?.author ?? "-"
        view.backgroundColor = .systemBackground
        
        // add a button in the navigtion bar
        let barButton = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(tapInfoButton))
        navigationItem.rightBarButtonItem = barButton 
    }

     //MARK: - Event Handler
     

    @objc func tapInfoButton() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
