import Foundation
import JSONCodable

/// One field in a collection schema.
open class CollectionField<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case facet = "facet"
        case index = "index"
        case name = "name"
        case `optional` = "optional"
        case sort = "sort"
        case type = "type"
        case data
    }

    /// Whether the field can be faceted on.
    public let facet: Bool?
    /// 
    public let index: Bool?
    /// 
    public let name: String
    /// 
    public let `optional`: Bool?
    /// 
    public let sort: Bool?
    /// Typesense field type, e.g. `string`, `int64`, `string[]`, `object`.
    public let type: String
    /// Additional properties
    public let data: T

    init(
        facet: Bool?,
        index: Bool?,
        name: String,
        `optional`: Bool?,
        sort: Bool?,
        type: String,
        data: T
    ) {
        self.facet = facet
        self.index = index
        self.name = name
        self.`optional` = `optional`
        self.sort = sort
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.facet = try container.decodeIfPresent(Bool.self, forKey: .facet)
        self.index = try container.decodeIfPresent(Bool.self, forKey: .index)
        self.name = try container.decode(String.self, forKey: .name)
        self.`optional` = try container.decodeIfPresent(Bool.self, forKey: .`optional`)
        self.sort = try container.decodeIfPresent(Bool.self, forKey: .sort)
        self.type = try container.decode(String.self, forKey: .type)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(facet, forKey: .facet)
        try container.encodeIfPresent(index, forKey: .index)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(`optional`, forKey: .`optional`)
        try container.encodeIfPresent(sort, forKey: .sort)
        try container.encode(type, forKey: .type)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "facet": facet as Any,
            "index": index as Any,
            "name": name as Any,
            "optional": `optional` as Any,
            "sort": sort as Any,
            "type": type as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> CollectionField {
        return CollectionField(
            facet: map["facet"] as? Bool,
            index: map["index"] as? Bool,
            name: map["name"] as! String,
            optional: map["optional"] as? Bool,
            sort: map["sort"] as? Bool,
            type: map["type"] as! String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
