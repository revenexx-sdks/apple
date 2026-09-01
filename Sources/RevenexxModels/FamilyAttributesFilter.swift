import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `family_attributes` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class FamilyAttributesFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_id = "attribute_id"
        case created_at = "created_at"
        case family_id = "family_id"
        case id = "id"
        case is_required = "is_required"
        case position = "position"
        case required_channels = "required_channels"
        case data
    }

    /// The literal `?attribute_id=` value this call was understood to carry.
    public let attribute_id: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?family_id=` value this call was understood to carry.
    public let family_id: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?is_required=` value this call was understood to carry.
    public let is_required: String?
    /// The literal `?position=` value this call was understood to carry.
    public let position: String?
    /// The literal `?required_channels=` value this call was understood to carry.
    public let required_channels: String?
    /// Additional properties
    public let data: T

    init(
        attribute_id: String?,
        created_at: String?,
        family_id: String?,
        id: String?,
        is_required: String?,
        position: String?,
        required_channels: String?,
        data: T
    ) {
        self.attribute_id = attribute_id
        self.created_at = created_at
        self.family_id = family_id
        self.id = id
        self.is_required = is_required
        self.position = position
        self.required_channels = required_channels
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_id = try container.decodeIfPresent(String.self, forKey: .attribute_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_required = try container.decodeIfPresent(String.self, forKey: .is_required)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.required_channels = try container.decodeIfPresent(String.self, forKey: .required_channels)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_id, forKey: .attribute_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(family_id, forKey: .family_id)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_required, forKey: .is_required)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(required_channels, forKey: .required_channels)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_id": attribute_id as Any,
            "created_at": created_at as Any,
            "family_id": family_id as Any,
            "id": id as Any,
            "is_required": is_required as Any,
            "position": position as Any,
            "required_channels": required_channels as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FamilyAttributesFilter {
        return FamilyAttributesFilter(
            attribute_id: map["attribute_id"] as? String,
            created_at: map["created_at"] as? String,
            family_id: map["family_id"] as? String,
            id: map["id"] as? String,
            is_required: map["is_required"] as? String,
            position: map["position"] as? String,
            required_channels: map["required_channels"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
