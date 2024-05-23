//
//  LoginViewController.swift
//  Navigation
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabaseInternal

final class LoginViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    var loginScrollView = UIScrollView().mask()
    var contentView = UIView().mask()
    var vkLogo: UIImageView = {
        let imageView = UIImageView().mask()
        imageView.image = UIImage(named: "vkLogo")
        return imageView
    }()
    
    var loginStackView: UIStackView = {
        let stack = UIStackView().mask()
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = LayoutConstants.cornerRadius
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()
    
    var loginField: UITextField = {
        let login = UITextField().mask()
        login.placeholder = "Логин: "
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.clearButtonMode = UITextField.ViewMode.whileEditing
        login.returnKeyType = .done
        return login
    }()
    
    var passwordField: UITextField = {
        let password = UITextField().mask()
        password.leftViewMode = .always
        password.placeholder = "Пароль: "
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.clearButtonMode = UITextField.ViewMode.whileEditing
        password.returnKeyType = .done
        return password
    }()
    var loginDelegate: LoginViewControllerDelegate?
    lazy var loginButton = CustomButton(title: "Войти", titleColor: .white, buttonAction: didTapSignInButton)
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас еще нет аккаунта?"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(registrButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
        //        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
        //        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubviews(vkLogo, loginStackView, loginButton, registrationLabel, registrationButton)
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        loginField.delegate = self
        passwordField.delegate = self
        setupConstraints()
        buttonDisable()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            
            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor,
                                                constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: LayoutConstants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: LayoutConstants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor,
                                             constant: LayoutConstants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: LayoutConstants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                  constant: LayoutConstants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registrationLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
                                                   constant: 32 ),//LayoutConstants.indent
            registrationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            registrationButton.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor,
                                                    constant: 4),
            registrationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        ])
    }
    private func buttonDisable() {
        if (((loginField.text?.isEmpty) != nil) && (passwordField.text?.isEmpty) != nil)  {
            loginButton.alpha = 0.5
        } else {
            loginButton.alpha = 1
        }
    }
    private func didTapSignInButton() {
        checkID(email: loginField.text, password: passwordField.text)
    }
    private func checkID(email: String?, password: String?) {
        // при нажатии на кнопку войти ( правильно введеные логин и пароль, открывается экран пользователя)
        guard let login = email, let password = password else {
            return
        }
        Task { @MainActor in
            do {
                try await AuthManager.shared.logIn(email: login, password: password)
                let profileVC = ProfileViewController()
                navigationController?.setViewControllers([profileVC], animated: true)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        //        guard let checkResult = self.loginDelegate?.checkCredentials(mail: login, password: password),
        //              checkResult
        //        else {
        //            tapAlertButton()
        //            return
        //        }
        
#if DEBUG
        //        guard let user = TestUserService.shared.identification(login: "testDebug") else {
        //            return
        //        }
#else
        //        guard let user = CurrentUserService.shared.identification(login: "testRelease") else {
        //            return
        //        }
#endif
        //        if user.login == login {
        //            let profileVC = ProfileViewController()
        //            navigationController?.setViewControllers([profileVC], animated: true)
        //        } else {
        //            print("Access is denied")
        //            alertButton()
        //        }
    }
    private func alertButton() {
        let button = CustomButton(title: "Access is denied", titleColor: .white, buttonAction: alerButtonTapped)
        button.backgroundColor = .systemGray
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnScreen))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func alerButtonTapped() {
        let alert = UIAlertController(title: "You entered the wrong credentials",
                                      message: "Enter the credentials again?",
                                      preferredStyle: .alert)
        // add two buttons
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            print("Yes")
        }
        alert.addAction(yes)
        
        let no = UIAlertAction(title: "No", style: .destructive) { _ in
            print("No")
        }
        alert.addAction(no)
        
        self.present(alert, animated: true, completion: nil)
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
    // MARK: - Event handlers
    
    @objc func registrButton() {
        // открвывается модальное окно с регистрацией
        let modalScreenWithAuth = AuthScreen()
        modalScreenWithAuth.completionAuth = { [weak self] login, password in
            self?.checkID(email: login, password: password)
        }
        present(modalScreenWithAuth, animated: true, completion: nil)
    }
    @objc func tapAlertButton() {
        alerButtonTapped()
    }
    @objc private func didTapOnScreen() {
        tapAlertButton()
    }
    
    @objc func willShowKeyboard(_notification: NSNotification) {
        let keyboardHeight = (_notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        loginScrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    @objc func willHideKeyboard(_ notification: NSNotification) {
        loginScrollView.contentInset.bottom = 0.0
    }
    
    @objc private func touchLoginButton() {
        didTapSignInButton()
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentOffset.y = keyboardSize.height - (loginScrollView.frame.height - loginButton.frame.minY)
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let login = loginField.text!
        let password = passwordField.text!
        if (!login.isEmpty && !password.isEmpty) {
            Auth.auth().signIn(withEmail: login, password: password) { (result, error) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            showAlert()
        }
        return true
    }
}
