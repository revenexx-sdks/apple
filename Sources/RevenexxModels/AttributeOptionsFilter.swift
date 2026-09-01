import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `attribute_options` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class AttributeOptionsFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_id = "attribute_id"
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case labels = "labels"
        case position = "position"
        case swatch = "swatch"
        case data
    }

    /// The literal `?attribute_id=` value this call was understood to carry.
    public let attribute_id: String?
    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// The literal `?position=` value this call was understood to carry.
    public let position: String?
    /// The literal `?swatch=` value this call was understood to carry.
    public let swatch: String?
    /// Additional properties
    public let data: T

    init(
        attribute_id: String?,
        code: String?,
        created_at: String?,
        id: String?,
        labels: String?,
        position: String?,
        swatch: String?,
        data: T
    ) {
        self.attribute_id = attribute_id
        self.code = code
        self.created_at = created_at
        self.id = id
        self.labels = labels
        self.position = position
        self.swatch = swatch
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_id = try container.decodeIfPresent(String.self, forKey: .attribute_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.swatch = try container.decodeIfPresent(String.self, forKey: .swatch)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_id, forKey: .attribute_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(swatch, forKey: .swatch)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_id": attribute_id as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "labels": labels as Any,
            "position": position as Any,
            "swatch": swatch as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeOptionsFilter {
        return AttributeOptionsFilter(
            attribute_id: map["attribute_id"] as? String,
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? String,
            position: map["position"] as? String,
            swatch: map["swatch"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
