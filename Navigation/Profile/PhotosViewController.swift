//
//  PhotosViewController.swift
//  Navigation
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let photoIdent = "photoCell"
    
    // MARK: Visual objects
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }() 
    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: layout).mask()
        photos.backgroundColor = .white
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photoIdent)
        return photos
    }()
    
    // MARK: - Setup section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery"
        self.view.addSubview(photosCollectionView)
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        setupConstraints()
        
        //NotificationCenter
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                NotificationCenter.default.addObserver(self!,
                                                       selector: #selector(self!.notificationAction),
                                                       name: .reloadPhoto,
                                                       object: nil)
            }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        //NotificationCenter отписка
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notificationAction(_ notification: NSNotification) {
        guard let object = notification.object as? String else { return }
        print("NotificationCenter in VC ")
        print("object = \(object)")
    }
}

// MARK: - Extensions

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItem: CGFloat = 2 
        let accessibleWidth = collectionView.frame.width - 32
        let widthItem = (accessibleWidth / countItem)
        return CGSize(width: widthItem, height: widthItem * 0.7) //0.56
    }
}

extension PhotosViewController: UICollectionViewDataSource { 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Photos.shared.examples.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.configCellCollection(photo: Photos.shared.examples[indexPath.item])
        return cell
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        ImagePublisherFacade().removeSubscription(for: ImageLibrarySubscriber.self as! ImageLibrarySubscriber)
        var somePic = ImagePublisherFacade()
        somePic.addImagesWithTimer(time: 3, repeat: 25, userImages: [UIImage.init()])
    }
}
    // NotificationCenter
    extension NSNotification.Name {
        static let reloadPhoto = NSNotification.Name("reloadPhoto")
    }
