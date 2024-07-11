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
        title = "Favorites"
    }
    
    // MARK: - Event Handler
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  likePosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = likePosts[indexPath.row].postAuthor
//        config.image = likePosts[indexPath.row].image
//        config.text = likePosts[indexPath.row].descriptionName
        config.secondaryText = likePosts[indexPath.row].dateCreated?.formatted()
//        config.secondaryText = likePosts[indexPath.row].likes.formatted()
//        config.secondaryText = likePosts[indexPath.row].views.formatted()
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
