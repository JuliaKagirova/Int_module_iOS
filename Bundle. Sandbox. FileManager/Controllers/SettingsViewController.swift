//
//  SettingsViewController.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 30.05.2024.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    //MARK: - Properties
    var model = Model(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    var viewModel = ViewModel(store: UserDefaultsStore())
    var coordinator: MainCoordinator?
    private lazy var alphabetOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Показать в алфавитном порядке"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var sortSwitch: UISwitch = {
        let swith = UISwitch()
        swith.translatesAutoresizingMaskIntoConstraints = false
        swith.addTarget(self, action: #selector(sortSwitchTapped), for: .valueChanged)
        swith.isOn = true
        return swith
    }()
    private lazy var photoSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Показать размер фотографии"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var photoSizeSwith: UISwitch = {
        let swith = UISwitch()
        swith.translatesAutoresizingMaskIntoConstraints = false
        swith.addTarget(self, action: #selector(photoSizeSwithTapped), for: .valueChanged)
        swith.isOn = true
        return swith
    }()
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поменять пароль", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createAddSettingsButton()
    }
    //MARK: - Private Methods
    
    private func setupUI() {
        title = "Настройки"
        view.backgroundColor = .systemBackground
        view.addSubview(alphabetOrderLabel)
        view.addSubview(sortSwitch)
        view.addSubview(photoSizeLabel)
        view.addSubview(photoSizeSwith)
        view.addSubview(changePasswordButton)
        NSLayoutConstraint.activate([
            alphabetOrderLabel.bottomAnchor.constraint(equalTo: photoSizeLabel.topAnchor,
                                                       constant: -42),
            alphabetOrderLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                     constant: 22),
            sortSwitch.bottomAnchor.constraint(equalTo: photoSizeSwith.topAnchor,
                                               constant: -26),
            sortSwitch.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                              constant: -22),
            photoSizeLabel.bottomAnchor.constraint(equalTo: changePasswordButton.topAnchor,
                                                   constant: -44),
            photoSizeLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                 constant: 22),
            photoSizeSwith.topAnchor.constraint(equalTo: changePasswordButton.topAnchor,
                                                constant: -68),
            photoSizeSwith.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                  constant: -22),
            changePasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                         constant: -42),
            changePasswordButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                       constant: 22),
            changePasswordButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                        constant: -22),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    private func createAddSettingsButton() {
        let addSettingsButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [addSettingsButton]
    }
    
    //MARK: - Event Handlers
    
    @objc private func sortSwitchTapped() {
        if sortSwitch.isOn {
            model.items = model.items.sorted()
        } else {
            model.items = Array(model.items.reversed())
        }
        tableView.reloadData()
    }
    
    @objc private func photoSizeSwithTapped() {
        if photoSizeSwith.isOn {
            //model.items
            let image = UIImage(named: "myImage")!
            let size = image.size
//            model.title = "Размер: \(size)"
        } else {
        }
    }
    @objc private func changePasswordButtonTapped() {
//        coordinator?.start()
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        coordinator?.start()

    }
    
    @objc private func didTapAddButton() {
        TextPicker.showAddSettings(in: self) {[ weak self] text in
            self?.viewModel.addItem(title: text)
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text =  viewModel.settings[indexPath.row].title
        config.secondaryText = viewModel.settings[indexPath.row].date.formatted()
        cell.contentConfiguration = config
        cell.accessoryType = viewModel.settings[indexPath.row].isCompleted ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else  if editingStyle == .insert {
            
        }
    }
}
