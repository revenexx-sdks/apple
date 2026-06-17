import Foundation
import JSONCodable

/// Indexes List
open class IndexList: Codable {

    enum CodingKeys: String, CodingKey {
        case indexes = "indexes"
        case total = "total"
    }

    /// List of indexes.
    public let indexes: [Index]
    /// Total number of indexes that matched your query.
    public let total: Int

    init(
        indexes: [Index],
        total: Int
    ) {
        self.indexes = indexes
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.indexes = try container.decode([Index].self, forKey: .indexes)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(indexes, forKey: .indexes)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "indexes": indexes.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IndexList {
        return IndexList(
            indexes: (map["indexes"] as! [[String: Any]]).map { Index.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
