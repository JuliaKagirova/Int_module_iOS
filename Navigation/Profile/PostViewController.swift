//
//  PostViewController.swift
//  Navigation
//

import UIKit
import StorageService
 
 final class PostViewController: UIViewController {
     
     // MARK: - Properties

      var post: Post?
     
     // MARK: - Life Cycle

      override func viewDidLoad() {
<<<<<<< HEAD
        super.viewDidLoad()
    
=======
        super.viewDidLoad() 
        title = post?.author ?? "-"
        view.backgroundColor = .systemYellow
        
        // add a button in the navigtion bar
        let barButton = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(tapInfoButton))
        navigationItem.rightBarButtonItem = barButton 
    }
     
     // MARK: - Event handlers

    @objc func tapInfoButton() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
