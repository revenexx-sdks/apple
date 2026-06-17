import Foundation
import JSONCodable

/// Provider
open class Provider: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case credentials = "credentials"
        case enabled = "enabled"
        case name = "name"
        case options = "options"
        case provider = "provider"
        case type = "type"
    }

    /// Provider creation time in ISO 8601 format.
    public let createdAt: String
    /// Provider ID.
    public let id: String
    /// Provider update date in ISO 8601 format.
    public let updatedAt: String
    /// Provider credentials.
    public let credentials: [String: AnyCodable]
    /// Is provider enabled?
    public let enabled: Bool
    /// The name for the provider instance.
    public let name: String
    /// Provider options.
    public let options: [String: AnyCodable]?
    /// The name of the provider service.
    public let provider: String
    /// Type of provider.
    public let type: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        credentials: [String: AnyCodable],
        enabled: Bool,
        name: String,
        options: [String: AnyCodable]?,
        provider: String,
        type: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.credentials = credentials
        self.enabled = enabled
        self.name = name
        self.options = options
        self.provider = provider
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.credentials = try container.decode([String: AnyCodable].self, forKey: .credentials)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.name = try container.decode(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.provider = try container.decode(String.self, forKey: .provider)
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(credentials, forKey: .credentials)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encode(provider, forKey: .provider)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "credentials": credentials as Any,
            "enabled": enabled as Any,
            "name": name as Any,
            "options": options as Any,
            "provider": provider as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Provider {
        return Provider(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            credentials: map["credentials"] as! [String: AnyCodable],
            enabled: map["enabled"] as! Bool,
            name: map["name"] as! String,
            options: map["options"] as? [String: AnyCodable],
            provider: map["provider"] as! String,
            type: map["type"] as! String
        )
    }
}
