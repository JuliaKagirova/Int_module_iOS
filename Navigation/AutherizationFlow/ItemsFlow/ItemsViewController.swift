//
//  ItemsViewController.swift
//  Navigation
//
//  Created by Юлия Кагирова on 19.06.2024.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    private var itemsManager: ItemsManager
    
    private lazy var button: UIButton = {
        let button = UIButton().mask()
        button.setTitle(" Добавить фото ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    
    
    init(itemsManager: ItemsManager) {
        self.itemsManager = itemsManager
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    private func setupUI() {
        view.backgroundColor = .systemYellow
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc private func buttonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemsManager.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let customImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        cell.addSubviews(customImageView)
        if let imageView = (cell.subviews[0] as? UIImageView) {
            imageView.image = UIImage(data: itemsManager.items[indexPath.row].imageData ?? Data())
        }
//        var config = UIListContentConfiguration.cell()
//        cell.customImageView.image = UIImage(data: itemsManager.items[indexPath.row].imageData ?? Data() )
//        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemsManager.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

extension ItemsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage, let imageData = image.pngData() {
            itemsManager.addItem(imageData: imageData)
            picker.dismiss(animated: true) {
                self.tableView.reloadData()
            }
        }
    }
    
    func UIImageWriteToSavedPhotosAlbum(_ image: UIImage, _ completionTarget: Any?, _ completionSelector: Selector?, _ contextInfo: UnsafeMutableRawPointer?) {
        
    }
    
}
