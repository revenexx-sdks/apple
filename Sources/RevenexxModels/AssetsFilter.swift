import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `assets` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class AssetsFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case asset_family_id = "asset_family_id"
        case attribute_values = "attribute_values"
        case code = "code"
        case created_at = "created_at"
        case delivery_path = "delivery_path"
        case external_url = "external_url"
        case id = "id"
        case source = "source"
        case storage_asset_id = "storage_asset_id"
        case updated_at = "updated_at"
        case data
    }

    /// The literal `?asset_family_id=` value this call was understood to carry.
    public let asset_family_id: String?
    /// The literal `?attribute_values=` value this call was understood to carry.
    public let attribute_values: String?
    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?delivery_path=` value this call was understood to carry.
    public let delivery_path: String?
    /// The literal `?external_url=` value this call was understood to carry.
    public let external_url: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?source=` value this call was understood to carry.
    public let source: String?
    /// The literal `?storage_asset_id=` value this call was understood to carry.
    public let storage_asset_id: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        asset_family_id: String?,
        attribute_values: String?,
        code: String?,
        created_at: String?,
        delivery_path: String?,
        external_url: String?,
        id: String?,
        source: String?,
        storage_asset_id: String?,
        updated_at: String?,
        data: T
    ) {
        self.asset_family_id = asset_family_id
        self.attribute_values = attribute_values
        self.code = code
        self.created_at = created_at
        self.delivery_path = delivery_path
        self.external_url = external_url
        self.id = id
        self.source = source
        self.storage_asset_id = storage_asset_id
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.asset_family_id = try container.decodeIfPresent(String.self, forKey: .asset_family_id)
        self.attribute_values = try container.decodeIfPresent(String.self, forKey: .attribute_values)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.delivery_path = try container.decodeIfPresent(String.self, forKey: .delivery_path)
        self.external_url = try container.decodeIfPresent(String.self, forKey: .external_url)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.storage_asset_id = try container.decodeIfPresent(String.self, forKey: .storage_asset_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(asset_family_id, forKey: .asset_family_id)
        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(delivery_path, forKey: .delivery_path)
        try container.encodeIfPresent(external_url, forKey: .external_url)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(storage_asset_id, forKey: .storage_asset_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "asset_family_id": asset_family_id as Any,
            "attribute_values": attribute_values as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "delivery_path": delivery_path as Any,
            "external_url": external_url as Any,
            "id": id as Any,
            "source": source as Any,
            "storage_asset_id": storage_asset_id as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> AssetsFilter {
        return AssetsFilter(
            asset_family_id: map["asset_family_id"] as? String,
            attribute_values: map["attribute_values"] as? String,
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            delivery_path: map["delivery_path"] as? String,
            external_url: map["external_url"] as? String,
            id: map["id"] as? String,
            source: map["source"] as? String,
            storage_asset_id: map["storage_asset_id"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
