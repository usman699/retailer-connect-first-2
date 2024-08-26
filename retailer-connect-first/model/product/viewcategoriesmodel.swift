
import Foundation

// MARK: - Viewcategories
struct Viewcategories: Codable {
    let success: Bool
    let data: [viewcategoriesdata]
}

// MARK: - Datum
struct viewcategoriesdata: Codable {
    let id: Int
    let name: String
    let description: String?
    let type, status: String
}
