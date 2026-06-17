import Foundation
import JSONCodable

/// 
open class Location: Codable {

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case code = "code"
        case created_at = "created_at"
        case enabled = "enabled"
        case id = "id"
        case labels = "labels"
        case metadata = "metadata"
        case name = "name"
        case priority = "priority"
        case type = "type"
        case updated_at = "updated_at"
    }

    /// 
    public let address: [String: AnyCodable]?
    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let enabled: Bool?
    /// 
    public let id: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let priority: Int?
    /// 
    public let type: String?
    /// 
    public let updated_at: String?

    init(
        address: [String: AnyCodable]?,
        code: String?,
        created_at: String?,
        enabled: Bool?,
        id: String?,
        labels: [String: AnyCodable]?,
        metadata: [String: AnyCodable]?,
        name: String?,
        priority: Int?,
        type: String?,
        updated_at: String?
    ) {
        self.address = address
        self.code = code
        self.created_at = created_at
        self.enabled = enabled
        self.id = id
        self.labels = labels
        self.metadata = metadata
        self.name = name
        self.priority = priority
        self.type = type
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .address)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "address": address as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "enabled": enabled as Any,
            "id": id as Any,
            "labels": labels as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "priority": priority as Any,
            "type": type as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Location {
        return Location(
            address: map["address"] as? [String: AnyCodable],
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            enabled: map["enabled"] as? Bool,
            id: map["id"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            priority: map["priority"] as? Int,
            type: map["type"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
