//
//  CustomButton.swift
//  Navigation
//
//  Created by Юлия Кагирова on 17.11.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    //MARK: - Private Properties
    
    private var buttonAction: () -> Void
    
    //MARK: - Init
    
    init(title: String, titleColor: UIColor,buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        self.layer.cornerRadius = LayoutConstants.cornerRadius
        self.clipsToBounds = true
        self.alpha = 1
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Event Handler
    @objc private func didTapButton() {
        self.buttonAction()
    }
}
