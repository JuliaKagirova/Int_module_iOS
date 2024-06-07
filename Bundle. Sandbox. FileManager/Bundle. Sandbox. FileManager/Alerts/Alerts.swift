//
//  Alerts.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 04.06.2024.
//

import UIKit

final class Alerts {
    static let shared = Alerts()
    
    init() {}
    
    func alertMinimumCharacters(viewController: UIViewController) {
        let alert = UIAlertController(title: "",
                                      message: "Пароль должен быть больше 4 символов",
                                      preferredStyle: .alert)
        let no = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            print("No")
        }
        alert.addAction(no)
        viewController.present(alert, animated: true)
    }
    
    func alertEmptyField(viewController: UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    func accessDenied(viewController: UIViewController) {
        let alert = UIAlertController(title: "Неверный пароль", message: "Введите пароль еще раз", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        viewController.present(alert, animated: true)
    }
    
    func savePasswordAlert(viewController: UIViewController) {
        let alert = UIAlertController(title: "Сохранить пароль", message: "Чтобы продолжить, сохраните пароль в keychain.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
}
