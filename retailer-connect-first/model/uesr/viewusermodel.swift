

import Foundation

// MARK: - Customerviewmodel
struct Customerviewmodel: Codable {
    let success: Bool
    let data: Mainviewcustomer
    let totalPages, totalRecord: Int
}

// MARK: - DataClass
struct Mainviewcustomer: Codable {
    let currentPage: Int
    let data: [orignaldataviewcustomer]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [Linkviewcustomer]
    let nextPageURL, path: String
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
struct orignaldataviewcustomer: Codable {
    let id: Int
    let company: Company
    let branch, name, email, role: String
    let roleID: Int
    let status: String

    enum CodingKeys: String, CodingKey {
        case id, company, branch, name, email, role
        case roleID = "role_id"
        case status
    }
}

enum Company: String, Codable {
    case abdullahMobilee = "Abdullah Mobilee"
    case sparkSolutionz = "SparkSolutionz"
    case vostro = "Vostro"
}



// MARK: - Link
struct Linkviewcustomer: Codable {
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
