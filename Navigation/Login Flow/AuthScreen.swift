//
//  AuthScreen.swift
//  Navigation
//
//  Created by Юлия Кагирова on 16.05.2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabaseInternal

class AuthScreen: UIViewController {
    
    // MARK: - Private Properties
    var completionAuth: ((String, String) -> Void)?
    var loginScrollView = UIScrollView().mask()
    var loginDelegate: LoginViewControllerDelegate?
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите ваше имя"
        field.textColor = .black
        field.font = .systemFont(ofSize: 16)
        field.layer.cornerRadius = LayoutConstants.cornerRadius
        field.clipsToBounds = true
        field.backgroundColor = .systemBackground
        field.layer.borderColor = UIColor.systemBlue.cgColor
        field.layer.borderWidth = 0.35
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        field.leftView = paddingView
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var loginField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите ваш логин"
        field.textColor = .black
        field.font = .systemFont(ofSize: 16)
        field.layer.cornerRadius = LayoutConstants.cornerRadius
        field.clipsToBounds = true
        field.backgroundColor = .systemBackground
        field.layer.borderColor = UIColor.systemBlue.cgColor
        field.layer.borderWidth = 0.35
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        field.leftView = paddingView
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите ваш пароль"
        field.textColor = .black
        field.font = .systemFont(ofSize: 16)
        field.layer.cornerRadius = LayoutConstants.cornerRadius
        field.clipsToBounds = true
        field.backgroundColor = .systemBackground
        field.layer.borderColor = UIColor.systemBlue.cgColor
        field.layer.borderWidth = 0.35
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        field.leftView = paddingView
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var signInButton = CustomButton(title: "Войти", titleColor: .white, buttonAction: sighInTapped)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }
    
    // MARK: - Private Methods
    
    private func setupConstraints() {
        nameField.delegate = self
        loginField.delegate = self
        passwordField.delegate = self
        view.addSubview(loginScrollView)
        loginScrollView.addSubviews(label, nameField, loginField, passwordField, signInButton)
        NSLayoutConstraint.activate([
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                     constant: LayoutConstants.leadingMargin),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: LayoutConstants.trailingMargin),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginScrollView.widthAnchor.constraint(equalToConstant: 200),
            
            nameField.topAnchor.constraint(equalTo: label.bottomAnchor,
                                           constant: 46),
            nameField.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo:loginScrollView.trailingAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            nameField.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor),
            
            loginField.topAnchor.constraint(equalTo: nameField.bottomAnchor,
                                            constant: LayoutConstants.twentyTwo),
            loginField.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            loginField.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            loginField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor,
                                               constant: LayoutConstants.twentyTwo),
            passwordField.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: loginScrollView.topAnchor,
                                       constant: LayoutConstants.indent),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor,
                                              constant: LayoutConstants.twentyTwo),
            signInButton.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard),
            name: UIResponder.keyboardDidHideNotification,
            object: nil)
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil )
    }
    private func sighInTapped() {
        guard let login = loginField.text, !login.isEmpty,  let password = passwordField.text, !password.isEmpty else {
            print("No email or password found.")
            showAlert()
            return
        }
        guard password.count >= 6 else {
           alert()
            return
        }
        Task {
            do {
                let returnUserData = try await AuthManager.shared.createUser(email: login, password: password)
                print("Success")
                print(returnUserData)
                print(navigationController)
                dismiss(animated: true) { [weak self] in 
                    self?.completionAuth?(login, password)
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    private func alert() {
        let alert = UIAlertController(title: "",
                                      message: "Пароль должен быть больше 6 символов",
                                      preferredStyle: .alert)
        // add two buttons
        let yes = UIAlertAction(title: "Ввести пароль заново", style: .default) { _ in
            print("Yes")
        }
        alert.addAction(yes)
        
        let no = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            print("No")
        }
        alert.addAction(no)
        
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Event Handler
    
    @objc func willShowKeyboard(_notification: NSNotification) {
        let keyboardHeight = (_notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        loginScrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    @objc func willHideKeyboard(_ notification: NSNotification) {
        loginScrollView.contentInset.bottom = 0.0
    }
}

extension AuthScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
