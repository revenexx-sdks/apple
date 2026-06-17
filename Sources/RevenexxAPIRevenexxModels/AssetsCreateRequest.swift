import Foundation
import JSONCodable

/// 
open class AssetsCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case asset_family_id = "asset_family_id"
        case attribute_values = "attribute_values"
        case code = "code"
        case media_uuid = "media_uuid"
    }

    /// 
    public let asset_family_id: String
    /// 
    public let attribute_values: [String: AnyCodable]?
    /// 
    public let code: String
    /// 
    public let media_uuid: String?

    init(
        asset_family_id: String,
        attribute_values: [String: AnyCodable]?,
        code: String,
        media_uuid: String?
    ) {
        self.asset_family_id = asset_family_id
        self.attribute_values = attribute_values
        self.code = code
        self.media_uuid = media_uuid
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.asset_family_id = try container.decode(String.self, forKey: .asset_family_id)
        self.attribute_values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attribute_values)
        self.code = try container.decode(String.self, forKey: .code)
        self.media_uuid = try container.decodeIfPresent(String.self, forKey: .media_uuid)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(asset_family_id, forKey: .asset_family_id)
        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(media_uuid, forKey: .media_uuid)
    }

    public func toMap() -> [String: Any] {
        return [
            "asset_family_id": asset_family_id as Any,
            "attribute_values": attribute_values as Any,
            "code": code as Any,
            "media_uuid": media_uuid as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AssetsCreateRequest {
        return AssetsCreateRequest(
            asset_family_id: map["asset_family_id"] as! String,
            attribute_values: map["attribute_values"] as? [String: AnyCodable],
            code: map["code"] as! String,
            media_uuid: map["media_uuid"] as? String
        )
    }
}
