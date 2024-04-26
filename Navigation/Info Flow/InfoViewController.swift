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
        label.text = "Data: "
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.layer.cornerRadius = LayoutConstants.cornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var periodLabel: UILabel = {
        let label = UILabel().mask()
        label.textColor = .black
        label.text = "Orbital period: "
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.layer.cornerRadius = LayoutConstants.cornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var citatusLabel: UILabel = {
        let label = UILabel().mask()
        label.textColor = .black
        label.text = "Title: "
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.layer.cornerRadius = LayoutConstants.cornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let dataLabel = UILabel().mask()
        dataLabel.textColor = .black
        dataLabel.textAlignment = .center
        dataLabel.font = .systemFont(ofSize: 18)
        dataLabel.layer.cornerRadius = LayoutConstants.cornerRadius
        dataLabel.clipsToBounds = true
        dataLabel.numberOfLines = 0
        return dataLabel
    }()
    
    private lazy var orbitalPeriodDataLabel: UILabel = {
        let label = UILabel().mask()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.layer.cornerRadius = LayoutConstants.cornerRadius
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleData: UILabel = {
        let label = UILabel().mask()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.layer.cornerRadius = LayoutConstants.cornerRadius
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tapMeB: UIButton = {
        let button = CustomButton(title: "Tap me!", titleColor: .white, buttonAction: tapMeButton)
        return button
    }()
    
    private let networkClient: INetworkClient = NetworkClient()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
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
        networkClient.request(with: urlRequest) { [weak self ] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                do {
                    self.dataLabel.text = "\(data)"
                    
                    let period = try? self.decoder.decode(Time.self, from: data)
                    self.orbitalPeriodDataLabel.text = period?.orbitalPeriod 
                    
                    let time = period?.orbitalPeriod
                    completion(time, nil)
                    
                    let answerCitatus = try JSONDecoder().decode([Citatus].self, from: data)
                    let randomIndex: Int = Array(0...answerCitatus.count-1).randomElement()!
                    let title = answerCitatus[randomIndex].title
                    completion(title, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case .failure:
                break
            }
        }
    }
    
    private func setupUI() {
        view.addSubviews(tapMeB, labelWithTitle, dataLabel, periodLabel, orbitalPeriodDataLabel, citatusLabel, titleData)
        NSLayoutConstraint.activate([
            tapMeB.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: 300),
            tapMeB.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapMeB.heightAnchor.constraint(equalToConstant: 50),
            tapMeB.widthAnchor.constraint(equalToConstant: 100),
            
            labelWithTitle.topAnchor.constraint(equalTo: view.topAnchor,
                                                constant: 60),
            labelWithTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 20),
            
            dataLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: 60),
            dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -20),
            dataLabel.leadingAnchor.constraint(equalTo: labelWithTitle.trailingAnchor,
                                                constant: 20),
            
            periodLabel.topAnchor.constraint(equalTo: labelWithTitle.bottomAnchor,
                                             constant: 60),
            periodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: 20),
            
            orbitalPeriodDataLabel.topAnchor.constraint(equalTo: labelWithTitle.bottomAnchor,
                                                        constant: 60),
            orbitalPeriodDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -20),
            orbitalPeriodDataLabel.leadingAnchor.constraint(equalTo: periodLabel.trailingAnchor,
                                                            constant: 20),
            citatusLabel.topAnchor.constraint(equalTo: periodLabel.bottomAnchor,
                                              constant: 60),
            citatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: 20),
            
            titleData.topAnchor.constraint(equalTo: periodLabel.bottomAnchor,
                                           constant: 60),
            titleData.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -20),
            titleData.leadingAnchor.constraint(equalTo: citatusLabel.trailingAnchor,
                                               constant: 20),
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
                    self?.titleData.text = title
                }
//                if let period {
//                    DispatchQueue.main.async { [weak self] in
//                        self?.orbitalPeriodDataLabel.text = period
//                    }
//                 }
            } else if let error {
                DispatchQueue.main.async {  [ weak self ] in
                    self?.titleData.text = error
                }
            }
        }
    }
}
