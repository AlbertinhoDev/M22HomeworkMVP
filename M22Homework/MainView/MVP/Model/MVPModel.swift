import Foundation
import UIKit

// MARK: Models for network service
struct Quere: Decodable {
    var keyword: String = ""
    var pagesCount: Int?
    var films: [Films] = []
}

struct Films: Decodable {
    var nameRu: String?
    var nameEn: String?
    var type: String?
    var year: String?
    var description: String?
    var filmLength: String?
    var rating: String?
    var posterUrlPreview: String?
}

// MARK: Global model
struct Model {
    var nameRu: String
    var nameEn: String
    var type: String
    var year: String
    var description: String
    var filmLength: String
    var rating: String
    var posterUrlPreview: UIImage?
}

// MARK: Model for cell
struct CellLabelAndImageModel {
    let name: String
    let image: UIImage
}
