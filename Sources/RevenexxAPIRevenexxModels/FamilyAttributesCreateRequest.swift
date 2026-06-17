import Foundation
import JSONCodable

/// 
open class FamilyAttributesCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_id = "attribute_id"
        case family_id = "family_id"
        case is_required = "is_required"
        case position = "position"
        case required_channels = "required_channels"
    }

    /// 
    public let attribute_id: String
    /// 
    public let family_id: String
    /// 
    public let is_required: Bool?
    /// 
    public let position: Int?
    /// 
    public let required_channels: [String: AnyCodable]?

    init(
        attribute_id: String,
        family_id: String,
        is_required: Bool?,
        position: Int?,
        required_channels: [String: AnyCodable]?
    ) {
        self.attribute_id = attribute_id
        self.family_id = family_id
        self.is_required = is_required
        self.position = position
        self.required_channels = required_channels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_id = try container.decode(String.self, forKey: .attribute_id)
        self.family_id = try container.decode(String.self, forKey: .family_id)
        self.is_required = try container.decodeIfPresent(Bool.self, forKey: .is_required)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.required_channels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .required_channels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(attribute_id, forKey: .attribute_id)
        try container.encode(family_id, forKey: .family_id)
        try container.encodeIfPresent(is_required, forKey: .is_required)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(required_channels, forKey: .required_channels)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_id": attribute_id as Any,
            "family_id": family_id as Any,
            "is_required": is_required as Any,
            "position": position as Any,
            "required_channels": required_channels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FamilyAttributesCreateRequest {
        return FamilyAttributesCreateRequest(
            attribute_id: map["attribute_id"] as! String,
            family_id: map["family_id"] as! String,
            is_required: map["is_required"] as? Bool,
            position: map["position"] as? Int,
            required_channels: map["required_channels"] as? [String: AnyCodable]
        )
    }
}
