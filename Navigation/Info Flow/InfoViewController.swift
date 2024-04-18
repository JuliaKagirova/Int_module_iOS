//
//  InfoViewController.swift
//  Navigation
//

import UIKit

final class InfoViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    
    var coordinator: Coordinator?
    
    // MARK: - Private Properties
    
    private lazy var labelWithTitle: UILabel = {
        let label = UILabel().mask()
        label.textColor = .black
        label.text = "Title: "
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = LayoutConstants.cornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let dataLabel = UILabel().mask()
        dataLabel.textColor = .black
        dataLabel.textAlignment = .center
        dataLabel.font = .systemFont(ofSize: 18)
        dataLabel.layer.borderWidth = 1
        dataLabel.layer.cornerRadius = LayoutConstants.cornerRadius
        dataLabel.clipsToBounds = true
        dataLabel.numberOfLines = 0
        return dataLabel
    }()
    
    private lazy var tapMeB: UIButton = {
        let button = CustomButton(title: "Tap me!", titleColor: .white, buttonAction: tapMeButton)
        return button
    }()
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        createAlertButton()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func createAlertButton() {
        let button = CustomButton(title: "Alert", titleColor: .white, buttonAction: alertButton)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
    
    private func buttonTapped(completion: @escaping ((_ title: String?, _ error: String?) -> Void)) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") else
        { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self else { return }
            if let error {
                print("❌" , error.localizedDescription)
            }
            guard let data else {
                print("‼️ server error")
                return
            }
            do {
                let answer = try JSONDecoder().decode([Citatus].self, from: data)
                let randomIndex: Int = Array(0...answer.count-1).randomElement()!
                let title = answer[randomIndex].title
                completion(title, nil)
            } catch {
                completion(nil, error.localizedDescription)
            }
        }.resume()
    }
    
    private func setupUI() {
        view.addSubviews(tapMeB, labelWithTitle, titleLabel)
        NSLayoutConstraint.activate([
            tapMeB.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: 160),
            tapMeB.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapMeB.heightAnchor.constraint(equalToConstant: 50),
            tapMeB.widthAnchor.constraint(equalToConstant: 100),
            
            labelWithTitle.topAnchor.constraint(equalTo: view.topAnchor,
                                                constant: 60),
            labelWithTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 20),
            labelWithTitle.heightAnchor.constraint(equalToConstant: 50),
            labelWithTitle.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    //MARK: - Event Handler
    
    @objc func tapAlertButton() {
        alertButton()
    }
    @objc func tapMeButton() {
        buttonTapped { [ weak self ] title, error in
            if let title {
                DispatchQueue.main.async {  [ weak self ] in
                    self?.titleLabel.text = title
                }
            } else if let error {
                DispatchQueue.main.async {  [ weak self ] in
                    self?.titleLabel.text = error
                }
            }
        }
    }
}
