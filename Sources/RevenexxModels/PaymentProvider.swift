import Foundation
import JSONCodable

/// 
open class PaymentProvider: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case enabled = "enabled"
        case id = "id"
        case name = "name"
        case options = "options"
        case provider = "provider"
        case test_mode = "test_mode"
        case updated_at = "updated_at"
    }

    /// When this PSP was configured for the tenant.
    public let created_at: String?
    /// Only an enabled provider takes NEW payments: a method pointing at a disabled one falls through to the tenant's `fallback_provider`, and to a 422 if there is none. Nothing else reads it — capture, cancel and refund on the payments this PSP already holds go on working — which is what makes disabling the safe retirement and deleting the refused one.
    public let enabled: Bool?
    /// Id of the PSP configuration row — what the provider routes address. The provider itself is named by `provider`.
    public let id: String?
    /// Operator-facing name of the configuration. Defaults to the catalog label, and is worth changing when a tenant runs two accounts with one PSP.
    public let name: String?
    /// Per-provider switches this app understands, plus anything the merchant keeps beside them. Three keys are the app's own: `logo_url` (the bundled logo, filled in when the provider is seeded), `capture_method` and `three_ds` (what the prism driver does today). Free jsonb — an unknown key is stored and ignored.
    public let options: [String: AnyCodable]?
    /// The catalog code of the PSP this row configures — one row per provider per tenant. GET /payments/providers/catalog lists every code that may appear here. It is what every payment and every method naming this PSP resolves it by, so changing it is refused with 409 for as long as one of them does.
    public let provider: String?
    /// Whether the driver talks to the PSP's sandbox. New configurations start in test mode: a provider nobody verified must not touch live money.
    public let test_mode: Bool?
    /// When its configuration last changed — including a credential rotation, which is otherwise invisible from the outside.
    public let updated_at: String?

    init(
        created_at: String?,
        enabled: Bool?,
        id: String?,
        name: String?,
        options: [String: AnyCodable]?,
        provider: String?,
        test_mode: Bool?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.enabled = enabled
        self.id = id
        self.name = name
        self.options = options
        self.provider = provider
        self.test_mode = test_mode
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.options = try container.decodeIfPresent([String: AnyCodable].self, forKey: .options)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.test_mode = try container.decodeIfPresent(Bool.self, forKey: .test_mode)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(test_mode, forKey: .test_mode)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "enabled": enabled as Any,
            "id": id as Any,
            "name": name as Any,
            "options": options as Any,
            "provider": provider as Any,
            "test_mode": test_mode as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentProvider {
        return PaymentProvider(
            created_at: map["created_at"] as? String,
            enabled: map["enabled"] as? Bool,
            id: map["id"] as? String,
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            provider: map["provider"] as? String,
            test_mode: map["test_mode"] as? Bool,
            updated_at: map["updated_at"] as? String
        )
    }
}
