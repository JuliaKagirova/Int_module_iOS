//
//  FeedViewController.swift
//  Navigation
//

import UIKit

final class FeedViewController: UIViewController {

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        createSubView()
    }

    //MARK: - Private Methods
    
    private func createSubView() {
        let stackView = UIStackView().mask()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView) 
        NSLayoutConstraint.activate([ 
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
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
    //MARK: - Event Handler
    @objc func tapPostButton() {
        postButton()
    }
}
