//
//  LoginViewController.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 30.05.2024.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    var completionAuth: ((String) -> Void)?
    var coordinator: LoginCoordinatorProtocol?
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password... "
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.textColor = .label
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 20
        field.borderStyle = .roundedRect
        field.backgroundColor = .systemBackground
        return field
    }()
//    var password = ""
//    var status = ""
//    var account = ""
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    private lazy var accountField: UITextField = {
        let account = UITextField()
        account.font = .systemFont(ofSize: 16, weight: .regular)
        account.placeholder = "Account..."
        account.textColor = .label
        account.translatesAutoresizingMaskIntoConstraints = false
        account.layer.cornerRadius = 20
        account.borderStyle = .roundedRect
        account.backgroundColor = .systemBackground
        return account
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        title = "Регистрация"
        view.addSubview(accountField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        passwordField.delegate = self
        NSLayoutConstraint.activate([
            accountField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62),
            accountField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 22),
            accountField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -22),
            accountField.heightAnchor.constraint(equalToConstant: 55),
            
            passwordField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 22),
            passwordField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -22),
            passwordField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 22),
            loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -22),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            
        ])
    }
//    func passSaved() {
//        
//        accountField.text = account
//        passwordField.text = password
//        
//        do {
//           status = try  KeychainManager.save(password: password.data(using: .utf8) ?? Data(), //passwordField.data(using: .utf8) ?? Data()
//                                  account: account )
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
      
    //MARK: - Event Handlers
    
    @objc private func loginButtonTapped() {
        guard let password = passwordField.text, !password.isEmpty else {
            Alerts.shared.alertEmptyField(viewController: self)
            return
        }
        guard password.count >= 4 else {
            Alerts.shared.alertMinimumCharacters(viewController: self)
            return
        }
        
        coordinator?.pushLoginButton()
        
    }
}

//MARK: - Extensions

extension LoginViewController: UITextFieldDelegate {
}
