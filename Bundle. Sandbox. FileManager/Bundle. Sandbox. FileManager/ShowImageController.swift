//
//  ShowImageController.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 28.05.2024.
//

import Foundation
import UIKit

final class ShowImageController: UIViewController {
    
    //MARK: - Properties
    
    var viewForImage: UIImage = {
        let view = UIImage()
        return view
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       // setupUI()
    }
    
    
    //MARK: - Private Methods
    
//    private func setupUI () {
//        view.addSubview(viewForImage)
//        NSLayoutConstraint.activate([
//            viewForImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            viewForImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            viewForImage.widthAnchor.constraint(equalToConstant: 150),
//            viewForImage.heightAnchor.constraint(equalToConstant: 150)
//
//        ])
//    }
}
