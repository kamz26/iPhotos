import Foundation

// MARK: - PhotoModel
struct PhotoModel: Codable , Hashable{
    let id, author: String?
    let width, height: Int?
    let downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height
        case downloadURL = "download_url"
    }
    
    var aspectRatio: CGFloat {
        if let width, let height {
            return CGFloat(height) / CGFloat(width)
        }
        return 1.0
    }
}

typealias PhotoModels = [PhotoModel]
