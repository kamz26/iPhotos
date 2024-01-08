import Foundation
import UIKit
import Combine

final class PhotosCollectionViewCellViewModel: Hashable {
    let photosURL: String
    var image: UIImage?
    var aspectRatio: CGFloat
    init(photosUrl: String,
         aspectRatio: CGFloat){
        self.photosURL = photosUrl
        self.aspectRatio = aspectRatio
    }
    
    func updateImage(image: UIImage){
        self.image = image
    }
    
    static func == (lhs: PhotosCollectionViewCellViewModel, rhs: PhotosCollectionViewCellViewModel) -> Bool {
        return lhs.photosURL == rhs.photosURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(photosURL)
    }
}
