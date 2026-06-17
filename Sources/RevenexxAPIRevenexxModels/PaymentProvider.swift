import Foundation
import JSONCodable

/// 
open class PaymentProvider: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case credentials = "credentials"
        case enabled = "enabled"
        case id = "id"
        case name = "name"
        case options = "options"
        case provider = "provider"
        case test_mode = "test_mode"
        case updated_at = "updated_at"
        case webhook_secret = "webhook_secret"
    }

    /// 
    public let created_at: String?
    /// 
    public let credentials: [String: AnyCodable]?
    /// 
    public let enabled: Bool?
    /// 
    public let id: String?
    /// 
    public let name: String?
    /// 
    public let options: [String: AnyCodable]?
    /// 
    public let provider: String?
    /// 
    public let test_mode: Bool?
    /// 
    public let updated_at: String?
    /// 
    public let webhook_secret: String?

    init(
        created_at: String?,
        credentials: [String: AnyCodable]?,
        enabled: Bool?,
        id: String?,
        name: String?,
        options: [String: AnyCodable]?,
        provider: String?,
        test_mode: Bool?,
        updated_at: String?,
        webhook_secret: String?
    ) {
        self.created_at = created_at
        self.credentials = credentials
        self.enabled = enabled
        self.id = id
        self.name = name
        self.options = options
        self.provider = provider
        self.test_mode = test_mode
        self.updated_at = updated_at
        self.webhook_secret = webhook_secret
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.credentials = try container.decodeIfPresent([String: AnyCodable].self, forKey: .credentials)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.test_mode = try container.decodeIfPresent(Bool.self, forKey: .test_mode)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.webhook_secret = try container.decodeIfPresent(String.self, forKey: .webhook_secret)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(credentials, forKey: .credentials)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(test_mode, forKey: .test_mode)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(webhook_secret, forKey: .webhook_secret)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "credentials": credentials as Any,
            "enabled": enabled as Any,
            "id": id as Any,
            "name": name as Any,
            "options": options as Any,
            "provider": provider as Any,
            "test_mode": test_mode as Any,
            "updated_at": updated_at as Any,
            "webhook_secret": webhook_secret as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentProvider {
        return PaymentProvider(
            created_at: map["created_at"] as? String,
            credentials: map["credentials"] as? [String: AnyCodable],
            enabled: map["enabled"] as? Bool,
            id: map["id"] as? String,
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            provider: map["provider"] as? String,
            test_mode: map["test_mode"] as? Bool,
            updated_at: map["updated_at"] as? String,
            webhook_secret: map["webhook_secret"] as? String
        )
    }
}
