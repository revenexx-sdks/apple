import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// A method needs its identity: code + name.
open class PaymentMethodCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case countries = "countries"
        case description = "description"
        case enabled = "enabled"
        case fee_amount = "fee_amount"
        case fee_currency = "fee_currency"
        case fee_type = "fee_type"
        case kind = "kind"
        case labels = "labels"
        case max_order_value = "max_order_value"
        case metadata = "metadata"
        case min_order_value = "min_order_value"
        case name = "name"
        case position = "position"
        case provider = "provider"
        case provider_method = "provider_method"
    }

    /// Stable method code (unique per tenant, e.g. &#039;invoice&#039;, &#039;card&#039;).
    public let code: String
    /// Allowed ISO country codes — empty/omitted = unrestricted.
    public let countries: [String]?
    /// 
    public let description: String?
    /// Disabled methods are never eligible (default false).
    public let enabled: Bool?
    /// Fixed amount or percent value, per fee_type (default 0).
    public let fee_amount: Double?
    /// ISO 4217 code (default EUR).
    public let fee_currency: String?
    /// How &#039;fee_amount&#039; applies (default &#039;none&#039;).
    public let fee_type: Revenexx API — revenexxEnums.PaymentFeeType?
    /// Self-managed (merchant fulfils, default) or PSP-backed (&#039;provider&#039; required to transact).
    public let kind: Revenexx API — revenexxEnums.PaymentMethodKind?
    /// Localized display names ({ de, en, … }).
    public let labels: [String: AnyCodable]?
    /// Maximum order amount — omitted = no upper bound.
    public let max_order_value: Double?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Minimum order amount — omitted = no lower bound.
    public let min_order_value: Double?
    /// Display name.
    public let name: String
    /// Sort position in the checkout (default 0).
    public let position: Int?
    /// PSP code from the catalog — only for kind &#039;psp&#039;.
    public let provider: String?
    /// The provider&#039;s payment method id (e.g. &#039;card&#039;, &#039;paypal&#039;).
    public let provider_method: String?

    init(
        code: String,
        countries: [String]?,
        description: String?,
        enabled: Bool?,
        fee_amount: Double?,
        fee_currency: String?,
        fee_type: Revenexx API — revenexxEnums.PaymentFeeType?,
        kind: Revenexx API — revenexxEnums.PaymentMethodKind?,
        labels: [String: AnyCodable]?,
        max_order_value: Double?,
        metadata: [String: AnyCodable]?,
        min_order_value: Double?,
        name: String,
        position: Int?,
        provider: String?,
        provider_method: String?
    ) {
        self.code = code
        self.countries = countries
        self.description = description
        self.enabled = enabled
        self.fee_amount = fee_amount
        self.fee_currency = fee_currency
        self.fee_type = fee_type
        self.kind = kind
        self.labels = labels
        self.max_order_value = max_order_value
        self.metadata = metadata
        self.min_order_value = min_order_value
        self.name = name
        self.position = position
        self.provider = provider
        self.provider_method = provider_method
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.countries = try container.decodeIfPresent([String].self, forKey: .countries)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.fee_amount = try container.decodeIfPresent(Double.self, forKey: .fee_amount)
        self.fee_currency = try container.decodeIfPresent(String.self, forKey: .fee_currency)
        if let fee_typeString = try container.decodeIfPresent(String.self, forKey: .fee_type) {
            self.fee_type = Revenexx API — revenexxEnums.PaymentFeeType(rawValue: fee_typeString)
        } else {
            self.fee_type = nil
        }
        if let kindString = try container.decodeIfPresent(String.self, forKey: .kind) {
            self.kind = Revenexx API — revenexxEnums.PaymentMethodKind(rawValue: kindString)
        } else {
            self.kind = nil
        }
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.max_order_value = try container.decodeIfPresent(Double.self, forKey: .max_order_value)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.min_order_value = try container.decodeIfPresent(Double.self, forKey: .min_order_value)
        self.name = try container.decode(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.provider_method = try container.decodeIfPresent(String.self, forKey: .provider_method)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(countries, forKey: .countries)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(fee_amount, forKey: .fee_amount)
        try container.encodeIfPresent(fee_currency, forKey: .fee_currency)
        try container.encodeIfPresent(fee_type?.rawValue, forKey: .fee_type)
        try container.encodeIfPresent(kind?.rawValue, forKey: .kind)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(max_order_value, forKey: .max_order_value)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(min_order_value, forKey: .min_order_value)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(provider_method, forKey: .provider_method)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "countries": countries as Any,
            "description": description as Any,
            "enabled": enabled as Any,
            "fee_amount": fee_amount as Any,
            "fee_currency": fee_currency as Any,
            "fee_type": fee_type?.rawValue as Any,
            "kind": kind?.rawValue as Any,
            "labels": labels as Any,
            "max_order_value": max_order_value as Any,
            "metadata": metadata as Any,
            "min_order_value": min_order_value as Any,
            "name": name as Any,
            "position": position as Any,
            "provider": provider as Any,
            "provider_method": provider_method as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentMethodCreateRequest {
        return PaymentMethodCreateRequest(
            code: map["code"] as! String,
            countries: map["countries"] as? [String],
            description: map["description"] as? String,
            enabled: map["enabled"] as? Bool,
            fee_amount: map["fee_amount"] as? Double,
            fee_currency: map["fee_currency"] as? String,
            fee_type: map["fee_type"] as? String != nil ? PaymentFeeType(rawValue: map["fee_type"] as! String) : nil,
            kind: map["kind"] as? String != nil ? PaymentMethodKind(rawValue: map["kind"] as! String) : nil,
            labels: map["labels"] as? [String: AnyCodable],
            max_order_value: map["max_order_value"] as? Double,
            metadata: map["metadata"] as? [String: AnyCodable],
            min_order_value: map["min_order_value"] as? Double,
            name: map["name"] as! String,
            position: map["position"] as? Int,
            provider: map["provider"] as? String,
            provider_method: map["provider_method"] as? String
        )
    }
}
