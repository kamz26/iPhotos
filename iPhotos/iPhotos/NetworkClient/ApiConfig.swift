import Foundation

struct ApiConfig {
    let scheme: Scheme
    let host: BaseUrl
}

enum Scheme: String {
    case https
    var value: String{
        return rawValue
    }
}

enum BaseUrl: String {
    case jsonBlobBaseUrl = "jsonblob.com"
    var baseUrl: String {
        return rawValue
    }
}

enum Endpoint: String {
    case photos = "/api/jsonBlob/1182735235283804160"
    var value: String {
        return rawValue
    }
}


enum HTTPMethod: String {
    case GET = "GET"
    var value: String {
        return rawValue
    }
}
