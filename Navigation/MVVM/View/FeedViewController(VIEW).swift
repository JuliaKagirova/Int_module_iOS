//  FeedViewController.swift
//  Navigation

import UIKit

final class FeedViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: FeedViewModelProtocol
    var newTextField: UITextField = {
        let passField = UITextField().mask()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        passField.leftView = paddingView
        passField.leftViewMode = .always
        passField.placeholder = " Enter your password: Pass"
        passField.layer.borderColor = UIColor.lightGray.cgColor
        passField.layer.borderWidth = 0.25
        passField.layer.cornerRadius = LayoutConstants.cornerRadius
        passField.keyboardType = .emailAddress
        passField.textColor = .black
        passField.font = UIFont.systemFont(ofSize: 16)
        passField.autocapitalizationType = .none
        passField.clearButtonMode = UITextField.ViewMode.whileEditing
        passField.returnKeyType = .done
        passField.backgroundColor = .systemFill
        return passField
    }()
    lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Password", titleColor: .white, buttonAction: didTapCheckButton)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.25
        return button
    }()
    let colorButton: UILabel = {
        let colorButton = UILabel()
        colorButton.backgroundColor = .white
        colorButton.layer.cornerRadius = LayoutConstants.cornerRadius
        colorButton.layer.borderColor = UIColor.lightGray.cgColor
        colorButton.layer.borderWidth = 0.25
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.textColor = .white
        colorButton.font = .systemFont(ofSize: 16)
        colorButton.textAlignment = .center
        colorButton.clipsToBounds = true
        return colorButton
    }()
    
    //MARK: - Life Cycle
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createSubView()
        setups()
        bindingModel()
    }

     
    // MARK: - Private Methods

    private func createSubView() {
        let stackView = UIStackView().mask()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
        addPostButton(title: "Post number One", color: .systemPurple, to: stackView, selector: #selector(tapPostButton))
        addPostButton(title: "Post number Two", color: .systemIndigo, to: stackView, selector: #selector(tapPostButton))
    }
    
    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = CustomButton(title: title, titleColor: .white, buttonAction: postButton)
        button.backgroundColor = color
        view.addArrangedSubview(button)
    }
    
    private func postButton() {
        let post = postExamples[0]
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
  
    private func setups() {
        let stackView = UIStackView().mask()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.addArrangedSubview(newTextField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(colorButton)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
    }

    
    private func bindingModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                ()
            case .success:
                self.colorButton.backgroundColor = .systemGreen
                self.colorButton.text = "OK"
            case .error:
                self.colorButton.backgroundColor = .systemRed
                self.colorButton.text = "Wrong password"
            }
        }
    }
    
    //MARK: - Event Handler
    
    @objc func tapPostButton() {
        postButton()
    }
    func didTapCheckButton() {
        viewModel.didTapCheckButton(text: newTextField.text)
    }
}
