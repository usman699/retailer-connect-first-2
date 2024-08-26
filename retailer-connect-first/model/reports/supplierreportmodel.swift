
import Foundation

// MARK: - Supplierreport
struct Supplierreportmodel: Codable {
    let success: Bool
    let data: maindatasupplier
    let totalPages, totalRecord: Int
}

// MARK: - DataClass
struct maindatasupplier: Codable {
    let currentPage: Int
    let data: [orignalsupplier]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [linksupplier]
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct orignalsupplier: Codable {
    let createdAt, supplierName: String
    let supplierBalance: Int
    let productName, productCode: String
    let purchasePrice: Int
    let totalQuantity: String
    let totalPurchase, totalTax: Int

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case supplierName, supplierBalance, productName, productCode, purchasePrice, totalQuantity, totalPurchase, totalTax
    }
}

// MARK: - Link
struct linksupplier: Codable {
    let url: String?
    let label: String
    let active: Bool
}

// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
