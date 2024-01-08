import Foundation
import Combine

protocol PhotosViewControllerViewModelProtocol {
    var router: PhotosRoutingProtocol { get set }
    func didSelectPhoto(at index: Int)
    func fetchPhotos() -> AnyPublisher<[PhotosCollectionViewCellViewModel], Error>
}

final class PhotosViewControllerViewModel: PhotosViewControllerViewModelProtocol {
    private let photosService: PhotosServiceProtocol
    var router: PhotosRoutingProtocol
    private var photosCollectionViewModels: [PhotosCollectionViewCellViewModel] = []
    init(service: PhotosServiceProtocol,
         router: PhotosRoutingProtocol){
        self.photosService = service
        self.router = router
    }
    
    func fetchPhotos() -> AnyPublisher<[PhotosCollectionViewCellViewModel], Error> {
        return photosService.fetchPhotos()
            .map { [weak self] photos in
                guard let `self` = self else { return  [] }
                self.photosCollectionViewModels = photos.map { PhotosCollectionViewCellViewModel(photosUrl: $0.downloadURL ?? "", aspectRatio: $0.aspectRatio)}
                return self.photosCollectionViewModels
                
            }
            .eraseToAnyPublisher()
        
    }
    
    func didSelectPhoto(at index: Int) {
        let selectedViewModel = self.photosCollectionViewModels[index]
        router.openDetailsView(selectedImage:selectedViewModel.image,
                                   aspectRatio: selectedViewModel.aspectRatio)
    }
}
