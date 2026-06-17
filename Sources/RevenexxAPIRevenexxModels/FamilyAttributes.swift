import Foundation
import JSONCodable

/// 
open class FamilyAttributes: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_id = "attribute_id"
        case created_at = "created_at"
        case family_id = "family_id"
        case id = "id"
        case is_required = "is_required"
        case position = "position"
        case required_channels = "required_channels"
    }

    /// 
    public let attribute_id: String?
    /// 
    public let created_at: String?
    /// 
    public let family_id: String?
    /// 
    public let id: String?
    /// 
    public let is_required: Bool?
    /// 
    public let position: Int?
    /// 
    public let required_channels: [String: AnyCodable]?

    init(
        attribute_id: String?,
        created_at: String?,
        family_id: String?,
        id: String?,
        is_required: Bool?,
        position: Int?,
        required_channels: [String: AnyCodable]?
    ) {
        self.attribute_id = attribute_id
        self.created_at = created_at
        self.family_id = family_id
        self.id = id
        self.is_required = is_required
        self.position = position
        self.required_channels = required_channels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_id = try container.decodeIfPresent(String.self, forKey: .attribute_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_required = try container.decodeIfPresent(Bool.self, forKey: .is_required)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.required_channels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .required_channels)
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
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_id": attribute_id as Any,
            "created_at": created_at as Any,
            "family_id": family_id as Any,
            "id": id as Any,
            "is_required": is_required as Any,
            "position": position as Any,
            "required_channels": required_channels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FamilyAttributes {
        return FamilyAttributes(
            attribute_id: map["attribute_id"] as? String,
            created_at: map["created_at"] as? String,
            family_id: map["family_id"] as? String,
            id: map["id"] as? String,
            is_required: map["is_required"] as? Bool,
            position: map["position"] as? Int,
            required_channels: map["required_channels"] as? [String: AnyCodable]
        )
    }
}
