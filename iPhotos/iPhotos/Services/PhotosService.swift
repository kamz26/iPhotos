//
//  PhotosNetworkClient.swift
//  iPhotos
//
//  Created by abhishek.kas on 06/01/24.
//

import Foundation
import Combine

protocol PhotosServiceProtocol{
    func fetchPhotos() -> AnyPublisher<PhotoModels,Error>
}

final class PhotosService: PhotosServiceProtocol {
    
    private let networkClient: NetworkClient
    private let apiConfig: ApiConfig
    init(networkClient: NetworkClient,
         apiConfig: ApiConfig){
        self.networkClient = networkClient
        self.apiConfig = apiConfig
    }
    
    func fetchPhotos() -> AnyPublisher<PhotoModels,Error> {
        var urlComponent = URLComponents()
        urlComponent.scheme = apiConfig.scheme.value
        urlComponent.host = apiConfig.host.baseUrl
        urlComponent.path = Endpoint.photos.value
        
        guard let url = urlComponent.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.value
        return self.networkClient.requestApiCall(request: urlRequest)
    }
}
