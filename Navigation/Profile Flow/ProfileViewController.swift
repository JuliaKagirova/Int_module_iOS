//
//  ProfileViewController.swift
//  Navigation
//

import UIKit
import FirebaseAuth
import CoreData

enum State {
    case buttonPressed
    case notPressed
}

final class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    
    var coordinator: Coordinator?
    var profileCoordinator: ProfileCoordinator?
    var heart = PostTableViewCell().heartImage
    var likePosts: [LikePost] = []
    var state = State.notPressed
    static let headerIdent = "header"
    static let photoIdent = "photo"
    static let postIdent = "post"
    
    static var postTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped).mask()
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: headerIdent)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: photoIdent)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: postIdent)
        return table
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likePosts = CoreDataManager.shared.fetchLikePost()
        profileCoordinator = ProfileCoordinator(navigationController: self.navigationController!)
        
#if DEBUG
        view.backgroundColor = .systemPink
#else
        view.backgroundColor = .systemGreen
#endif
        
        view.addSubview(Self.postTableView)
        setupConstraints()
        Self.postTableView.dataSource = self
        Self.postTableView.delegate = self
        Self.postTableView.refreshControl = UIRefreshControl()
        Self.postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        let barButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(logoutButton))
        navigationItem.leftBarButtonItem = barButton
        
    }
    
    //MARK: - Private Properties
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            Self.postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Self.postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            Self.postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            Self.postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Event Handlers
    
    @objc func logoutButton() {
        Task {
            do {
                try AuthManager.shared.signOut()
                navigationController?.setViewControllers([LoginViewController()], animated: true)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    @objc func reloadTableView() {
        Self.postTableView.reloadData()
        Self.postTableView.refreshControl?.endRefreshing()
    }
    
    @objc private func doubleClickOnPost(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        like()
        //        heart.image = UIImage(systemName: "heart.fill")
        //        heart.tintColor = .red
        
        CoreDataManager.shared.addLikePost2()
        likePosts = CoreDataManager.shared.fetchLikePost()
//        findDuplicate()
      
        
        
//        isDuplicated()
        //        CoreDataManager.shared.addLikePost(post: Post.init(author: "author56", description: "descr", image: "image", likes: 22, views: 33))
        
        // Картинку здесь в этом задании можно не сохранять в CoreData, а так же читать из бандла как и в профиле.
    }
    
    private func like() { //heart -> button -> action 'like"
        if state == .notPressed {
            heart.image = UIImage(systemName: "heart.fill")
            heart.tintColor = .red
            state = .buttonPressed
        } else {
            heart.image = UIImage(systemName: "heart")
            heart.tintColor = .blue
            state = .notPressed
        }
    }
    
   
    
  
    
//    private func isDuplicated() {
//        for post in likePosts {
//            if let duplicate = CoreDataManager.shared.findDuplicate(postId: post.id) {
//              //delete duplicate from core data
//                //fetch likePosts
//            } else {
//                print("Duplicate not found")
//            }
//        }
//    }
}

// MARK: - Extensions

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return postExamples.count
        default:
            assertionFailure("no registered section")
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.photoIdent, for: indexPath) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.postIdent, for: indexPath) as! PostTableViewCell
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleClickOnPost))
            tapGesture.numberOfTapsRequired = 2
            cell.isUserInteractionEnabled = true
            cell.addGestureRecognizer(tapGesture)
            
            cell.configPostArray(post: postExamples[indexPath.row])
            return cell
        default:
            assertionFailure("no registered section")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerIdent) as! ProfileHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
            //            navigationController?.pushViewController(PhotosViewController(), animated: true)
            profileCoordinator?.showPhotosVC()
            
        case 1:
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            if let post = cell as? PostTableViewCell {
                post.incrementPostViewsCounter()
              
            }
        default:
            assertionFailure("no registered section")
        }
    }
}
