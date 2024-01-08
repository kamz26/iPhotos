import Foundation
import UIKit
import Combine

protocol PhotosLoadManagerProtocol{
    func loadImage(url: String) -> AnyPublisher<UIImage?,Never>
}

final class PhotosLoadManager: PhotosLoadManagerProtocol {
    
    let networkClient: NetworkClient
    let photosCacheManager: PhotosCacheManagerProtocol
    init(networkClient: NetworkClient,
         photosCacheManager:PhotosCacheManagerProtocol ){
        self.networkClient = networkClient
        self.photosCacheManager = photosCacheManager
    }
    
    
    func loadImage(url: String) -> AnyPublisher<UIImage?,Never> {
        guard let imageUrl = URL(string: url) else {
            return Just(nil)
                .eraseToAnyPublisher()
        }
        
        if let image = photosCacheManager[imageUrl] {
            return Just(image).eraseToAnyPublisher()
        }
        
        return networkClient
            .requesApiCall(requestUrl: imageUrl)
            .map{ data -> UIImage? in return UIImage(data: data)}
            .catch{ error in return Just(nil) }
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let photo = image else { return }
                self.photosCacheManager[imageUrl] = photo
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
