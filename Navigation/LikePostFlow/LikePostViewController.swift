//
//  LikePostViewController.swift
//  Navigation
//
//  Created by Юлия Кагирова on 03.07.2024.
//

import UIKit
import CoreData

class LikePostViewController: UITableViewController {
    
    // MARK: - Properties
    
    var likePosts = CoreDataManager.shared.likePosts
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchBar: UISearchBar = {
        let sB = UISearchBar()
        sB.placeholder = "enter author name..."
        sB.showsCancelButton = true
       
        sB.translatesAutoresizingMaskIntoConstraints = false
        return sB
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        tableView.reloadData()
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Favorites"
        view.addSubview(searchBar)
        searchBar.backgroundColor = .red
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
//        //left button - mGlass
//        let leftBarButton = UIBarButtonItem(
//            image: UIImage(systemName: "magnifyingglass"),
//            style: .done,
//            target: self,
//            action: #selector(searchBarSearchButtonClicked)
//        )
//        self.navigationItem.leftBarButtonItem = leftBarButton
//        
//        
//        
//        //right button - closeFilter
//        let rightBarButton = UIBarButtonItem(
//            image: UIImage(systemName: "xmark.circle"),
//            style: .plain,
//            target: self,
//            action: #selector(closeFilterButtonClicked)
//        )
//        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Event Handler
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            CoreDataManager.shared.likePosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id,
                                                       for: indexPath) as? PostTableViewCell
        else {
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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
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

// MARK: - Search bar methods

extension LikePostViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<LikePost> = LikePost.fetchRequest()
        print(searchBar.text!)
        let predicate = NSPredicate(format: "author CONTAINS [cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        loadItems(with: request, predicate: predicate )
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func loadItems(with request: NSFetchRequest<LikePost> =  LikePost.fetchRequest(), predicate: NSPredicate? = nil) {
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate])
        }
        do {
            likePosts = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}
