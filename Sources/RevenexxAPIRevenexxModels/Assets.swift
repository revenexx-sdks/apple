import Foundation
import JSONCodable

/// 
open class Assets: Codable {

    enum CodingKeys: String, CodingKey {
        case asset_family_id = "asset_family_id"
        case attribute_values = "attribute_values"
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case media_uuid = "media_uuid"
        case updated_at = "updated_at"
    }

    /// 
    public let asset_family_id: String?
    /// 
    public let attribute_values: [String: AnyCodable]?
    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let media_uuid: String?
    /// 
    public let updated_at: String?

    init(
        asset_family_id: String?,
        attribute_values: [String: AnyCodable]?,
        code: String?,
        created_at: String?,
        id: String?,
        media_uuid: String?,
        updated_at: String?
    ) {
        self.asset_family_id = asset_family_id
        self.attribute_values = attribute_values
        self.code = code
        self.created_at = created_at
        self.id = id
        self.media_uuid = media_uuid
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.asset_family_id = try container.decodeIfPresent(String.self, forKey: .asset_family_id)
        self.attribute_values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attribute_values)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.media_uuid = try container.decodeIfPresent(String.self, forKey: .media_uuid)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(asset_family_id, forKey: .asset_family_id)
        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(media_uuid, forKey: .media_uuid)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "asset_family_id": asset_family_id as Any,
            "attribute_values": attribute_values as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "media_uuid": media_uuid as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Assets {
        return Assets(
            asset_family_id: map["asset_family_id"] as? String,
            attribute_values: map["attribute_values"] as? [String: AnyCodable],
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            media_uuid: map["media_uuid"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
