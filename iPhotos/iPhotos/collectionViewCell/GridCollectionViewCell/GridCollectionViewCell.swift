import UIKit
import Combine

class GridCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "photosCell"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var imageLoader: PhotosLoadManagerProtocol = {
        let loader = PhotosLoadManager(networkClient: PhotosNetworkClient(), photosCacheManager: PhotosCacheManager())
        return loader
    }()
    
    private var subscription = Set<AnyCancellable>()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func construct(photoViewModel: PhotosCollectionViewCellViewModel){
        imageLoader.loadImage(url: photoViewModel.photosURL)
            .receive(on: RunLoop.main)
            .sink { [weak self] photo in
                guard let `self` = self else { return }
                guard let image = photo else { return }
                photoViewModel.updateImage(image: image)
                self.photoImageView.image = image
            }
            .store(in: &subscription)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        subscription = Set<AnyCancellable>()
    }
}
