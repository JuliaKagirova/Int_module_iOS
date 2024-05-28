//
//  ImagePicker.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 28.05.2024.
//

import UIKit
import PhotosUI

final class ImagePicker {
    
    //MARK: - Properties
    
    static let shared = ImagePicker()

    var completion: ((UIImage) -> Void)?
    
    //MARK: - Methods
    
    func showPicker(controller: UIViewController, selectionLimit: Int, completion: ((UIImage) -> Void)?) {
        DispatchQueue.main.async {
        self.completion = completion
        var configPicker = PHPickerConfiguration()
        configPicker.selectionLimit = selectionLimit
        let picker = PHPickerViewController(configuration: configPicker)
        picker.delegate = self
            controller.present(picker, animated: true)
        }
    }
}

//MARK: - Extension

extension ImagePicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let selectedImage = image as? UIImage {
                        self.completion?(selectedImage)
                    }
                }
            }
        }
        picker.dismiss(animated: true)
    }
}
