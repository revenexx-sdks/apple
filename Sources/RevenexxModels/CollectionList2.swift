import Foundation
import JSONCodable

/// Collections List
open class CollectionList2: Codable {

    enum CodingKeys: String, CodingKey {
        case collections = "collections"
        case total = "total"
    }

    /// List of collections.
    public let collections: [Collection2]
    /// Total number of collections that matched your query.
    public let total: Int

    init(
        collections: [Collection2],
        total: Int
    ) {
        self.collections = collections
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.collections = try container.decode([Collection2].self, forKey: .collections)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(collections, forKey: .collections)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "collections": collections.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CollectionList2 {
        return CollectionList2(
            collections: (map["collections"] as! [[String: Any]]).map { Collection2.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
