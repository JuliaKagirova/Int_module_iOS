//
//  LikePostViewController.swift
//  Navigation
//
//  Created by Юлия Кагирова on 03.07.2024.
//

import UIKit

class LikePostViewController: UITableViewController {
 
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        tableView.reloadData()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Favorites"
    }
    
    // MARK: - Event Handler
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataManager.shared.likePosts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.id,
            for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let model = CoreDataManager.shared.likePosts[indexPath.row]
        let modelForCell = Post(
            author: model.postAuthor ?? "",
            description: model.descriptionName ?? "",
            image: model.image ?? "",
            likes: Int32(Int(model.likes)),
            views: Int32(Int(model.views)),
            id: model.id ?? ""
        )
        cell.configPostArray(post: modelForCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteLikePost(likePost: CoreDataManager.shared.likePosts[indexPath.row])
            tableView.reloadData()
        } else if editingStyle == .insert {
        }
    }
}
