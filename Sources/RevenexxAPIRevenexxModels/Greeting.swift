import Foundation
import JSONCodable

/// 
open class Greeting: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case locale = "locale"
        case message = "message"
        case metadata = "metadata"
        case name = "name"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let locale: String?
    /// 
    public let message: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let tenant_id: String?
    /// 
    public let updated_at: String?

    init(
        created_at: String?,
        id: String?,
        locale: String?,
        message: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.id = id
        self.locale = locale
        self.message = message
        self.metadata = metadata
        self.name = name
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(locale, forKey: .locale)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "locale": locale as Any,
            "message": message as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Greeting {
        return Greeting(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            locale: map["locale"] as? String,
            message: map["message"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
