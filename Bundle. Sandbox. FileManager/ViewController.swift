//
//  ViewController.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 28.05.2024.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //MARK: - Properties
//    var showImController = ShowImageController()
    var model = Model(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createButtons()
        setupTableView()
        title = model.title
    }
    
    //MARK: - Private Methods
    
    private func createButtons() {
        let createFolderButton = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(didTapCreateFolder))
        let addPhotoButton = UIBarButtonItem(image: UIImage(systemName: "photo.badge.plus"), style: .plain, target: self, action: #selector(didTapAddImage ))
        navigationItem.rightBarButtonItems = [createFolderButton, addPhotoButton]
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func showImagePicker() {
        DispatchQueue.main.async {
            var configForPicker = PHPickerConfiguration()
            configForPicker.selectionLimit = 1
            
            let pickerViewController = PHPickerViewController(configuration: configForPicker)
            pickerViewController.delegate = self
            pickerViewController.isEditing = true
            self.present(pickerViewController, animated: true)
        }
    }
    
    private func checkPermission() {
        if PHPhotoLibrary.authorizationStatus(for: .readWrite) == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .authorized {
                    self.showImagePicker()
                } else {
                    return
                }
            }
        } else if PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized {
            showImagePicker()
        } else {
            return
        }
    }
    
    //MARK: - Handlers
    
    @objc private func didTapCreateFolder() {
        TextPicker.showAddFolder(in: self) {[ weak self] text in
            self?.model.addFolder(title: text)
            self?.tableView.reloadData()
        }
    }
    
    @objc private func didTapAddImage() {
        checkPermission()
    }
}
//MARK: - Extensions

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteItem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config =  UIListContentConfiguration.cell()
        config.text = model.items[indexPath.row]
        cell.contentConfiguration = config
        cell.accessoryType = model.isPathForItemIsFolder(index: indexPath.row) ? .disclosureIndicator : .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model.isPathForItemIsFolder(index: indexPath.row) {
            let vc = ViewController()
            vc.model = Model(path: model.path + "/" + model.items[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let string = try! NSString(
                contentsOf: URL(filePath: model.path + "/" + model.items[indexPath.row]),
                encoding: NSUTF8StringEncoding
            )
            TextPicker.showAlert(in: self, title: model.items[indexPath.row], message: string as String)
        }
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    //добавляем вьюконтроллер в котором есть вьюха в которой откроется картинка
                    DispatchQueue.main.async {
//                        let showImageController = ShowImageController()
//                        self.navigationController?.present(showImageController, animated: true);
                        guard let imageData = image.jpegData(compressionQuality: 1) else {
                            print(error?.localizedDescription ?? "Something went wrong...")
                            return
                        }
                        self.model.addImage(image: imageData)
//                        image = showImageController.viewForImage
                        self.tableView.reloadData()
                        picker.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
}
