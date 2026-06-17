import Foundation
import JSONCodable

/// Phones List
open class PhoneList: Codable {

    enum CodingKeys: String, CodingKey {
        case phones = "phones"
        case total = "total"
    }

    /// List of phones.
    public let phones: [Phone]
    /// Total number of phones that matched your query.
    public let total: Int

    init(
        phones: [Phone],
        total: Int
    ) {
        self.phones = phones
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.phones = try container.decode([Phone].self, forKey: .phones)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(phones, forKey: .phones)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "phones": phones.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PhoneList {
        return PhoneList(
            phones: (map["phones"] as! [[String: Any]]).map { Phone.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
