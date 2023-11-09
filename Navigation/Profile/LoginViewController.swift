//
//  LoginViewController.swift
//  Navigation
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: UI
    
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
    
    var loginButton: UIButton = {
        let button = UIButton().mask()
        if let pixel = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(pixel.image(alpha: 1), for: .normal)
            button.setBackgroundImage(pixel.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(pixel.image(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(pixel.image(alpha: 0.4), for: .disabled)
        }
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(touchLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    var loginField: UITextField = {
        var login = UITextField().mask()
        login.placeholder = "Log In: testDebug"
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
        password.placeholder = "Password: debug"
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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }
    
    //Mark: - Private Methods
    
    private func setupViews() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        contentView.addSubviews(vkLogo, loginStackView, loginButton)
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        loginField.delegate = self
        passwordField.delegate = self
        setupConstraints()
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

            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),

            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: LayoutConstants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    private func checkID() {
        // Сообщение о том что логин или пароль пустые
        guard let login = self.loginField.text, let password = self.passwordField.text else { return }
        // UIAlertController с ошибкой, что лог и пасс неверные
        guard let checkResult = self.loginDelegate?.check(login: login, password: password), checkResult  else {
            tapAlertButton()
            return }
        
#if DEBUG
        guard let user = TestUserService.shared.identification(login: "testDebug") else {
            return
        }
#else
        guard let user = CurrentUserService.shared.identification(login: "testRelease") else {
            return
        }
#endif
        if user.login == login {
            let profileVC = ProfileViewController()
            navigationController?.setViewControllers([profileVC], animated: true)
        } else {
            print("Access is denied")
            alertButton()
        }
    }
    private func alertButton() {
        let button = UIButton().mask()
        button.setTitle("Access is denied", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.addTarget(self, action: #selector(tapAlertButton), for: .touchUpInside)
                
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
    
    // MARK: - Event handlers
    
    @objc func tapAlertButton() {
        
        let alert = UIAlertController(title: "You entered the wrong credentials",
                                      message: "Enter the credentials again?",
                                      preferredStyle: .alert)
        // add two buttons
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            print("Yes")
            // если нажать на ДА то вьюшка исчезачет , строка очисщается и можно ввести пвроль повторно
        }
        alert.addAction(yes)
        
        let no = UIAlertAction(title: "No", style: .destructive) { _ in
            print("No")
            
            // вьюшка с аксесс денеайд исчезает
        }
        alert.addAction(no)

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func willShowKeyboard(_notification: NSNotification) {
        let keyboardHeight = (_notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        loginScrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        loginScrollView.contentInset.bottom = 0.0
    }
    
    @objc private func didTapOnScreen() {
        tapAlertButton()
//        dismiss(animated: true)
    }

    @objc private func touchLoginButton() {
        checkID()
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
    
    // tap 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

