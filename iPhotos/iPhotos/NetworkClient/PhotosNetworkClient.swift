import Foundation
import Combine

protocol NetworkClient {
    func requestApiCall<T:Decodable>(request: URLRequest) -> AnyPublisher<T,Error>
    func requesApiCall(requestUrl: URL) -> AnyPublisher<Data, URLError>
}

final class PhotosNetworkClient: NetworkClient {
    let session: URLSession
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10
        return queue
    }()
    init(session: URLSession = URLSession.shared){
        self.session = session
    }
    
    func requestApiCall<T:Decodable>(request: URLRequest) -> AnyPublisher<T,Error>{
        return session
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func requesApiCall(requestUrl: URL) -> AnyPublisher<Data, URLError> {
        return session
            .dataTaskPublisher(for: requestUrl)
            .map(\.data)
            .subscribe(on: backgroundQueue)
            .eraseToAnyPublisher()
    }
}
