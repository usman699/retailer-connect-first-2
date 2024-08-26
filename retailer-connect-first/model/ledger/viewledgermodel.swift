

import Foundation

// MARK: - Empty
struct viewledgermodel: Codable {
    let success: Bool
    let data: mainviewledger
    let totalPages, totalRecord: Int
}

// MARK: - DataClass
struct mainviewledger: Codable {
    let currentPage: Int
    let data: [orignalviewledger]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [Linkledger]
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
struct orignalviewledger: Codable {
    let id: Int
    let date: String
    let description: String?
    let transactionType, ledgerType: String
    let type: String
    let amount: Int
    let bankID, bankName: String?

    enum CodingKeys: String, CodingKey {
        case id, date, description
        case transactionType = "transaction_type"
        case ledgerType = "ledger_type"
        case type, amount
        case bankID = "bank_id"
        case bankName = "bank_name"
    }
}

enum LedgerTypeEnum: String, Codable {
    case bank = "Bank"
    case expense = "Expense"
    case purchase = "Purchase"
}

enum TypeEnum: String, Codable {
    case credit = "credit"
    case debit = "debit"
}

// MARK: - Link
struct Linkledger: Codable {
    let url: String?
    let label: String
    let active: Bool
}

// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//            return true
//    }
//
//    public var hashValue: Int {
//            return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//            let container = try decoder.singleValueContainer()
//            if !container.decodeNil() {
//                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//            }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//            var container = encoder.singleValueContainer()
//            try container.encodeNil()
//    }
//}
