import Foundation
import JSONCodable
import RevenexxEnums

/// Database
open class Database: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case enabled = "enabled"
        case name = "name"
        case type = "type"
    }

    /// Database creation date in ISO 8601 format.
    public let createdAt: String
    /// Database ID.
    public let id: String
    /// Database update date in ISO 8601 format.
    public let updatedAt: String
    /// If database is enabled. Can be 'enabled' or 'disabled'. When disabled, the database is inaccessible to users, but remains accessible to Server SDKs using API keys.
    public let enabled: Bool
    /// Database name.
    public let name: String
    /// Database type.
    public let type: RevenexxEnums.DatabaseType

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        enabled: Bool,
        name: String,
        type: RevenexxEnums.DatabaseType
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.enabled = enabled
        self.name = name
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = RevenexxEnums.DatabaseType(rawValue: try container.decode(String.self, forKey: .type))!
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(name, forKey: .name)
        try container.encode(type.rawValue, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "enabled": enabled as Any,
            "name": name as Any,
            "type": type.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Database {
        return Database(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            enabled: map["enabled"] as! Bool,
            name: map["name"] as! String,
            type: DatabaseType(rawValue: map["type"] as! String)!
        )
    }
}
