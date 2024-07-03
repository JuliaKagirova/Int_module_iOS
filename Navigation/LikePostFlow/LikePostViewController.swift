//
//  LikePostViewController.swift
//  Navigation
//
//  Created by Юлия Кагирова on 03.07.2024.
//

import UIKit

class LikePostViewController: UITableViewController {

    // MARK: - Private Properties
    
    private var likePosts: [LikePost] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likePosts = CoreDataManager.shared.fetchLikePost()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Likes List"
//        let button = CustomButton(title: "Likes", titleColor: .white, buttonAction: likePostButtonDidTapped)
//        view.addSubview(button)
//        NSLayoutConstraint.activate([
//            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            button.heightAnchor.constraint(equalToConstant: 50),
//            button.widthAnchor.constraint(equalToConstant: 350),
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
    }
    
    // MARK: - Event Handler
    
    @objc func likePostButtonDidTapped() {
        CoreDataManager.shared.addLikePost(title: "New like")
        likePosts = CoreDataManager.shared.fetchLikePost()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  likePosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = likePosts[indexPath.row].name
        config.secondaryText = likePosts[indexPath.row].dateCreated?.formatted()
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteLikePost(likePost: likePosts[indexPath.row])
            likePosts = CoreDataManager.shared.fetchLikePost()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

// MARK: - Extensions

