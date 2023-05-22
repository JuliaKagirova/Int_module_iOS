//
//  PhotosCollectionViewCell.swift
//  Navigation
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    var photo = UIImageView().mask()

    // MARK: - Init section
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Error")
    }
     
    private func setupConstraints() {
        self.contentView.addSubview(photo)
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Run loop
    
    public func configCellCollection(photo: UIImage) {
        self.photo.image = photo
    }
}

