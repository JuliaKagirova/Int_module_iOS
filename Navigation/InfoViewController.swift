//
//  InfoViewController.swift
//  Navigation
//

import UIKit

final class InfoViewController: UIViewController {
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        createAlertButton()
    }
  
    // MARK: - Private Methods

    private func createAlertButton() {
        let button = CustomButton(title: "Alert", titleColor: .white, buttonAction: alertButton)
        button.backgroundColor = .systemPink
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
private func alertButton() {
        let alert = UIAlertController(title: "Attention",
                                      message: "How are you feeling?",
                                      preferredStyle: .alert)
        // add two buttons
        let fine = UIAlertAction(title: "Fine", style: .default) { _ in
            print("Fine")
        }
        alert.addAction(fine)
        
        let so = UIAlertAction(title: "Okey", style: .destructive) { _ in
            print("Okey")
        }
        alert.addAction(so)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Event Handler
    
    @objc func tapAlertButton() {
        alertButton()
    }
}
