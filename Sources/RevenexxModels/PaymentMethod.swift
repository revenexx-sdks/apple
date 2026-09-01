import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class PaymentMethod: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case countries = "countries"
        case created_at = "created_at"
        case description = "description"
        case enabled = "enabled"
        case fee_amount = "fee_amount"
        case fee_currency = "fee_currency"
        case fee_type = "fee_type"
        case id = "id"
        case kind = "kind"
        case labels = "labels"
        case max_order_value = "max_order_value"
        case metadata = "metadata"
        case min_order_value = "min_order_value"
        case name = "name"
        case position = "position"
        case provider = "provider"
        case provider_method = "provider_method"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// The machine name of the method, unique per tenant and lower case by convention ('invoice', 'prepayment', 'card', 'paypal'). It is the string the checkout asks for, the string every payment stores, and therefore the one value here that cannot be changed freely: renaming it would leave the ledger naming something that no longer exists, so it is refused with 409 for as long as any payment names it.
    public let code: String?
    /// Allowed ISO 3166-1 alpha-2 country codes, compared upper-cased against the buyer country. null or an empty list means unrestricted — the invoice method this app seeds is restricted to DE, which is why an eligibility call without a country sees it excluded.
    public let countries: [String]?
    /// When this configuration was created.
    public let created_at: String?
    /// One line explaining the method where it is offered — payment terms, what happens after the order. Shown to the buyer, so it is the merchant's wording rather than the app's.
    public let description: String?
    /// A disabled method is never eligible and never reaches a checkout. This is the switch an operator wants: deleting a method the ledger still names — or renaming its `code` — is refused with 409.
    public let enabled: Bool?
    /// The surcharge this method costs the buyer, read as an amount or as a percentage depending on `fee_type`. Never negative — a discount for paying a certain way is not expressible here.
    public let fee_amount: Double?
    /// ISO 4217 code a fixed fee is expressed in. The database bounds the length at three characters and nothing else, so lower case is stored as written.
    public let fee_currency: String?
    /// How `fee_amount` applies: 'none' (no surcharge), 'fixed' (that many units of `fee_currency`) or 'percent' (that share of the order amount).
    public let fee_type: RevenexxEnums.PaymentFeeType?
    /// Id of the configuration row. A payment names its method by `code`, never by this — so an id is only ever used to address the configuration itself.
    public let id: String?
    /// Who moves the money. 'self_managed' — invoice, prepayment — means the merchant fulfils and reconciles it outside any PSP, and such a payment authorizes the moment it is created. 'psp' means a configured provider authorizes, captures and refunds it.
    public let kind: RevenexxEnums.PaymentMethodKind?
    /// Buyer-facing names keyed by language tag — what a storefront shows instead of the operator-facing `name`. Free jsonb: the database constrains neither the tags nor the values, so a client reads the tag it wants and falls back to `en`.
    public let labels: [String: AnyCodable]?
    /// Largest order amount this method may be used for — the usual credit-risk cap on invoice and prepayment. null means no upper bound.
    public let max_order_value: Double?
    /// Free-form merchant data carried on the configuration. This app never reads it — it is storage for the integrations that do (an ERP key for the method, a ledger account, a display hint).
    public let metadata: [String: AnyCodable]?
    /// Smallest order amount this method may be used for — the usual guard against paying a €5 order by invoice. null means no lower bound.
    public let min_order_value: Double?
    /// Operator-facing name, in the language the merchant administers in. What a buyer sees comes from `labels`.
    public let name: String?
    /// Sort order at checkout, ascending — the merchant's preferred payment method first.
    public let position: Int?
    /// The PSP code this method transacts through, from GET /payments/providers/catalog. Only meaningful for kind 'psp'; a PSP method that names none falls back to the tenant's `default_provider` setting.
    public let provider: String?
    /// The provider's own payment-method id ('card', 'paypal', 'sepa_debit') — what the driver is told to charge. Copied onto every payment created with this method as `metadata.provider_method`.
    public let provider_method: String?
    /// The tenant the row belongs to — the same slug the request carried in `X-Revenexx-Tenant`. Added by the platform rather than by this app, and echoed so a caller that fans several tenants into one store can tell the rows apart.
    public let tenant_id: String?
    /// When it was last changed. The eligibility answer is computed live, so this is the age of the configuration and not of any cached result.
    public let updated_at: String?

    init(
        code: String?,
        countries: [String]?,
        created_at: String?,
        description: String?,
        enabled: Bool?,
        fee_amount: Double?,
        fee_currency: String?,
        fee_type: RevenexxEnums.PaymentFeeType?,
        id: String?,
        kind: RevenexxEnums.PaymentMethodKind?,
        labels: [String: AnyCodable]?,
        max_order_value: Double?,
        metadata: [String: AnyCodable]?,
        min_order_value: Double?,
        name: String?,
        position: Int?,
        provider: String?,
        provider_method: String?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.code = code
        self.countries = countries
        self.created_at = created_at
        self.description = description
        self.enabled = enabled
        self.fee_amount = fee_amount
        self.fee_currency = fee_currency
        self.fee_type = fee_type
        self.id = id
        self.kind = kind
        self.labels = labels
        self.max_order_value = max_order_value
        self.metadata = metadata
        self.min_order_value = min_order_value
        self.name = name
        self.position = position
        self.provider = provider
        self.provider_method = provider_method
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.countries = try container.decodeIfPresent([String].self, forKey: .countries)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.fee_amount = try container.decodeIfPresent(Double.self, forKey: .fee_amount)
        self.fee_currency = try container.decodeIfPresent(String.self, forKey: .fee_currency)
        if let fee_typeString = try container.decodeIfPresent(String.self, forKey: .fee_type) {
            self.fee_type = RevenexxEnums.PaymentFeeType(rawValue: fee_typeString)
        } else {
            self.fee_type = nil
        }
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        if let kindString = try container.decodeIfPresent(String.self, forKey: .kind) {
            self.kind = RevenexxEnums.PaymentMethodKind(rawValue: kindString)
        } else {
            self.kind = nil
        }
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.max_order_value = try container.decodeIfPresent(Double.self, forKey: .max_order_value)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.min_order_value = try container.decodeIfPresent(Double.self, forKey: .min_order_value)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.provider_method = try container.decodeIfPresent(String.self, forKey: .provider_method)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(countries, forKey: .countries)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(fee_amount, forKey: .fee_amount)
        try container.encodeIfPresent(fee_currency, forKey: .fee_currency)
        try container.encodeIfPresent(fee_type?.rawValue, forKey: .fee_type)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(kind?.rawValue, forKey: .kind)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(max_order_value, forKey: .max_order_value)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(min_order_value, forKey: .min_order_value)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(provider_method, forKey: .provider_method)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "countries": countries as Any,
            "created_at": created_at as Any,
            "description": description as Any,
            "enabled": enabled as Any,
            "fee_amount": fee_amount as Any,
            "fee_currency": fee_currency as Any,
            "fee_type": fee_type?.rawValue as Any,
            "id": id as Any,
            "kind": kind?.rawValue as Any,
            "labels": labels as Any,
            "max_order_value": max_order_value as Any,
            "metadata": metadata as Any,
            "min_order_value": min_order_value as Any,
            "name": name as Any,
            "position": position as Any,
            "provider": provider as Any,
            "provider_method": provider_method as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentMethod {
        return PaymentMethod(
            code: map["code"] as? String,
            countries: map["countries"] as? [String],
            created_at: map["created_at"] as? String,
            description: map["description"] as? String,
            enabled: map["enabled"] as? Bool,
            fee_amount: map["fee_amount"] as? Double,
            fee_currency: map["fee_currency"] as? String,
            fee_type: map["fee_type"] as? String != nil ? PaymentFeeType(rawValue: map["fee_type"] as! String) : nil,
            id: map["id"] as? String,
            kind: map["kind"] as? String != nil ? PaymentMethodKind(rawValue: map["kind"] as! String) : nil,
            labels: map["labels"] as? [String: AnyCodable],
            max_order_value: map["max_order_value"] as? Double,
            metadata: map["metadata"] as? [String: AnyCodable],
            min_order_value: map["min_order_value"] as? Double,
            name: map["name"] as? String,
            position: map["position"] as? Int,
            provider: map["provider"] as? String,
            provider_method: map["provider_method"] as? String,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
