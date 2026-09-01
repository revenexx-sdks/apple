import Foundation
import JSONCodable

/// Activates a catalog PSP for this tenant — providers are configuration, not code.
open class PaymentProviderCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case credentials = "credentials"
        case enabled = "enabled"
        case name = "name"
        case options = "options"
        case provider = "provider"
        case test_mode = "test_mode"
        case webhook_secret = "webhook_secret"
    }

    /// The PSP's own API credentials, under the key names its auth scheme expects — `GET /payments/providers/catalog` publishes them per provider as `credential_fields` (Stripe: `api_key`; PayPal: `client_id` + `client_secret`; Novalnet: `api_key` + `payment_access_key` + `tariff_id`). They come from the provider's own dashboard, are handed to the driver in-process, and are never read back by any route. Write-only: to rotate one, write the new value. Whatever a document shows here is a placeholder.
    public let credentials: [String: AnyCodable]?
    /// Only an enabled provider takes NEW payments: a method pointing at a disabled one falls through to the tenant's `fallback_provider`, and to a 422 if there is none. Nothing else reads it — capture, cancel and refund on the payments this PSP already holds go on working — which is what makes disabling the safe retirement and deleting the refused one. Defaults to false — finish the credentials before switching it on.
    public let enabled: Bool?
    /// Operator-facing name of the configuration. Defaults to the catalog label, and is worth changing when a tenant runs two accounts with one PSP. null, omitted or empty falls back to the catalog label.
    public let name: String?
    /// Per-provider switches this app understands, plus anything the merchant keeps beside them. Three keys are the app's own: `logo_url` (the bundled logo, filled in when the provider is seeded), `capture_method` and `three_ds` (what the prism driver does today). Free jsonb — an unknown key is stored and ignored.
    public let options: [String: AnyCodable]?
    /// The catalog code of the PSP this row configures — one row per provider per tenant. GET /payments/providers/catalog lists every code that may appear here. It is what every payment and every method naming this PSP resolves it by, so changing it is refused with 409 for as long as one of them does. Required on create, and refused with 400 when the catalog does not carry it.
    public let provider: String
    /// Whether the driver talks to the PSP's sandbox. New configurations start in test mode: a provider nobody verified must not touch live money. Unstated takes the tenant's own `test_mode_default` setting.
    public let test_mode: Bool?
    /// The signing secret the PSP issues when its webhook endpoint is created, in the provider's own dashboard. webhooks.revenexx.com verifies each callback against it before the dispatcher hands the envelope to this app. Write-only, like `credentials`: it is stored, used, and never read back by any route, so there is nothing to compare a value against — to rotate it, write the new one. Whatever a document shows here is a generated placeholder, not a usable secret — writing it verbatim leaves every callback failing verification.
    public let webhook_secret: String?

    init(
        credentials: [String: AnyCodable]?,
        enabled: Bool?,
        name: String?,
        options: [String: AnyCodable]?,
        provider: String,
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
        self.provider = try container.decode(String.self, forKey: .provider)
        self.test_mode = try container.decodeIfPresent(Bool.self, forKey: .test_mode)
        self.webhook_secret = try container.decodeIfPresent(String.self, forKey: .webhook_secret)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(credentials, forKey: .credentials)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(options, forKey: .options)
        try container.encode(provider, forKey: .provider)
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

    public static func from(map: [String: Any] ) -> PaymentProviderCreateRequest {
        return PaymentProviderCreateRequest(
            credentials: map["credentials"] as? [String: AnyCodable],
            enabled: map["enabled"] as? Bool,
            name: map["name"] as? String,
            options: map["options"] as? [String: AnyCodable],
            provider: map["provider"] as! String,
            test_mode: map["test_mode"] as? Bool,
            webhook_secret: map["webhook_secret"] as? String
        )
    }
}
