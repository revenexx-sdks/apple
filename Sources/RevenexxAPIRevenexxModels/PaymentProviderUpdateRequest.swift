import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class PaymentProviderUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case credentials = "credentials"
        case enabled = "enabled"
        case name = "name"
        case options = "options"
        case provider = "provider"
        case test_mode = "test_mode"
        case webhook_secret = "webhook_secret"
    }

    /// PSP credentials — the catalog&#039;s credential_fields say which keys the auth scheme expects.
    public let credentials: [String: AnyCodable]?
    /// Only enabled providers transact (default false).
    public let enabled: Bool?
    /// Display name — defaults to the catalog label.
    public let name: String?
    /// Free-form provider options.
    public let options: [String: AnyCodable]?
    /// Provider code — must exist in the catalog (GET /payments/providers/catalog).
    public let provider: String?
    /// Sandbox/test credentials (default true).
    public let test_mode: Bool?
    /// Shared secret for PSP callback verification.
    public let webhook_secret: String?

    init(
        credentials: [String: AnyCodable]?,
        enabled: Bool?,
        name: String?,
        options: [String: AnyCodable]?,
        provider: String?,
        test_mode: Bool?,
        webhook_secret: String?
    ) {
        self.credentials = credentials
        self.enabled = enabled
        self.name = name
        self.options = options
        self.provider = provider
        self.test_mode = test_mode
        self.webhook_secret = webhook_secret
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.credentials = try container.decodeIfPresent([String: AnyCodable].self, forKey: .credentials)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.test_mode = try container.decodeIfPresent(Bool.self, forKey: .test_mode)
        self.webhook_secret = try container.decodeIfPresent(String.self, forKey: .webhook_secret)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(credentials, forKey: .credentials)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(test_mode, forKey: .test_mode)
        try container.encodeIfPresent(webhook_secret, forKey: .webhook_secret)
    }

    public func toMap() -> [String: Any] {
        return [
            "credentials": credentials as Any,
            "enabled": enabled as Any,
            "name": name as Any,
            "options": options as Any,
            "provider": provider as Any,
            "test_mode": test_mode as Any,
            "webhook_secret": webhook_secret as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentProviderUpdateRequest {
        return PaymentProviderUpdateRequest(
            credentials: map["credentials"] as? [String: AnyCodable],
            enabled: map["enabled"] as? Bool,
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            provider: map["provider"] as? String,
            test_mode: map["test_mode"] as? Bool,
            webhook_secret: map["webhook_secret"] as? String
        )
    }
}
