//
//  TextPicker.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 26.05.2024.
//

import Foundation
import UIKit
import Photos
 
final class TextPicker {
     
    //MARK: - Methods
    
   static func showAlert(in viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let ok = UIAlertAction(title: "Ok", style: .default)
       alert.addAction(ok)
       viewController.present(alert, animated: true )
    }
    
    static func showAddFolder(in viewController: UIViewController, completion: @escaping ((_ text: String)-> Void)) {
        let alert = UIAlertController(title: "Create new folder  ", message: nil,  preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Folder name"
        }
        let create = UIAlertAction(title: "Create", style: .default) { _ in
            if let text = alert.textFields?[0].text {
                completion(text)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancel)
        alert.addAction(create)
        viewController.present(alert, animated: true )
     }
}
