import Foundation
import JSONCodable

/// Facet values and their counts for one faceted field.
open class FacetCount<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case counts = "counts"
        case field_name = "field_name"
        case data
    }

    /// 
    public let counts: [[String: AnyCodable]]?
    /// 
    public let field_name: String?
    /// Additional properties
    public let data: T

    init(
        counts: [[String: AnyCodable]]?,
        field_name: String?,
        data: T
    ) {
        self.counts = counts
        self.field_name = field_name
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.counts = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .counts)
        self.field_name = try container.decodeIfPresent(String.self, forKey: .field_name)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(counts, forKey: .counts)
        try container.encodeIfPresent(field_name, forKey: .field_name)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "counts": counts as Any,
            "field_name": field_name as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FacetCount {
        return FacetCount(
            counts: map["counts"] as? [[String: AnyCodable]],
            field_name: map["field_name"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
