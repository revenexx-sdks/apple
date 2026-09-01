import Foundation
import JSONCodable

/// 
open class CollectionList: Codable {

    enum CodingKeys: String, CodingKey {
        case collections = "collections"
    }

    /// Public collection names the tenant owns. These are the values accepted for the `collection` path parameter.
    public let collections: [String]

    init(
        collections: [String]
    ) {
        self.collections = collections
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.collections = try container.decode([String].self, forKey: .collections)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(collections, forKey: .collections)
    }

    public func toMap() -> [String: Any] {
        return [
            "collections": collections as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CollectionList {
        return CollectionList(
            collections: map["collections"] as! [String]
        )
    }
}
