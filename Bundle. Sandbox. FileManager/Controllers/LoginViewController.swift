//
//  LoginViewController.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 30.05.2024.
//

import UIKit

class LoginViewController: UIViewController, Coordinating {
    var coordinator: (any Coordinator)?
    
    
    //MARK: - Properties
    
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.textColor = .darkGray
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 10
        return field
    }()
    
    /// Экран должен содержать текстовое поле и кнопку.
 //   У экрана должно быть два состояния:

  //  пользователь не создавал пароль ранее;
 //   у пользователя есть сохранённый пароль;
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        view.addSubview(passwordField)
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            
            
            
        ])
    }
    
    
    
    //MARK: - Event Handlers
    
   
    
}

//MARK: - Extensions


