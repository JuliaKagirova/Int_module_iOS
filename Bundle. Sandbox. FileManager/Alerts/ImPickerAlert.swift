//
//  ImPickerAlert.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 28.05.2024.
//

import UIKit
import Photos

final class ImPickerAlert {
    
    static func addPhotoAlert(viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addPhoto = UIAlertAction(title: "Добавить фото", style: .default) { _ in
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    completion?()
                } else {
                    return
                }
            }
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("cancel")
        }
        alert.addAction(addPhoto)
        alert.addAction(cancel)
        viewController.present(alert, animated: true)
    }
}
