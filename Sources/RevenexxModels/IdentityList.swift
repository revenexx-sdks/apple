import Foundation
import JSONCodable

/// Identities List
open class IdentityList: Codable {

    enum CodingKeys: String, CodingKey {
        case identities = "identities"
        case total = "total"
    }

    /// List of identities.
    public let identities: [Identity]
    /// Total number of identities that matched your query.
    public let total: Int

    init(
        identities: [Identity],
        total: Int
    ) {
        self.identities = identities
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.identities = try container.decode([Identity].self, forKey: .identities)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(identities, forKey: .identities)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "identities": identities.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IdentityList {
        return IdentityList(
            identities: (map["identities"] as! [[String: Any]]).map { Identity.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
