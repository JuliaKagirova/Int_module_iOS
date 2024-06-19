//
//  AutherizationViewController.swift
//  Navigation
//
//  Created by Юлия Кагирова on 13.06.2024.
//

import UIKit

class AutherizationViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


class FoldersVC: UITableViewController {
    
    
    private lazy var button: UIButton = {
        let button = UIButton().mask()
        button.setTitle(" Добавить папку ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var folderManager = FolderManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc private func buttonTapped() {
        folderManager.addFolder(title: "new folder")
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderManager.folders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = folderManager.folders[indexPath.row].title
        config.secondaryText = folderManager.folders[indexPath.row].createdDate.formatted()
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            folderManager.deleteFolder(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folder = folderManager.folders[indexPath.row]
        let itemsManager = ItemsManager(folder: folder)
        let itemsViewController = ItemsViewController(itemsManager: itemsManager)
        navigationController?.pushViewController(itemsViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "rename") { [ weak self ] _, _, completion in
            guard let self else {
                
                return
            }
            self.folderManager.renameFolder(newTitle: "renamed folder", at: indexPath.row)
            self.tableView.reloadRows(at: [indexPath], with: .right)
            completion(true)
        }
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
}
