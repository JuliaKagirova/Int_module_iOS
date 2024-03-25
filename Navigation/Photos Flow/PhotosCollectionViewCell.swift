//
//  PhotosCollectionViewCell.swift
//  Navigation
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {


    //MARK: - Properties
    
    var photo = UIImageView().mask()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) { 
        fatalError("Error")
    }

    //MARK: - Private Methods
    
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

