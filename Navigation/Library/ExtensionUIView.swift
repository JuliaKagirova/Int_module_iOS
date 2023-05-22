//
//  ExtensionUIView.swift
//  Navigation
//

import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
    func mask() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
