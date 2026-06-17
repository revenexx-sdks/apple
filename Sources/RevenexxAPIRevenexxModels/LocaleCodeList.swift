import Foundation
import JSONCodable

/// Locale codes list
open class LocaleCodeList: Codable {

    enum CodingKeys: String, CodingKey {
        case localeCodes = "localeCodes"
        case total = "total"
    }

    /// List of localeCodes.
    public let localeCodes: [LocaleCode]
    /// Total number of localeCodes that matched your query.
    public let total: Int

    init(
        localeCodes: [LocaleCode],
        total: Int
    ) {
        self.localeCodes = localeCodes
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.localeCodes = try container.decode([LocaleCode].self, forKey: .localeCodes)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(localeCodes, forKey: .localeCodes)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "localeCodes": localeCodes.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LocaleCodeList {
        return LocaleCodeList(
            localeCodes: (map["localeCodes"] as! [[String: Any]]).map { LocaleCode.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
