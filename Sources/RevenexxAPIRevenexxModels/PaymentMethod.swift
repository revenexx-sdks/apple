import Foundation
import JSONCodable

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
        case updated_at = "updated_at"
    }

    /// 
    public let code: String?
    /// 
    public let countries: [String: AnyCodable]?
    /// 
    public let created_at: String?
    /// 
    public let description: String?
    /// 
    public let enabled: Bool?
    /// 
    public let fee_amount: Double?
    /// 
    public let fee_currency: String?
    /// 
    public let fee_type: String?
    /// 
    public let id: String?
    /// 
    public let kind: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let max_order_value: Double?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let min_order_value: Double?
    /// 
    public let name: String?
    /// 
    public let position: Int?
    /// 
    public let provider: String?
    /// 
    public let provider_method: String?
    /// 
    public let updated_at: String?

    init(
        code: String?,
        countries: [String: AnyCodable]?,
        created_at: String?,
        description: String?,
        enabled: Bool?,
        fee_amount: Double?,
        fee_currency: String?,
        fee_type: String?,
        id: String?,
        kind: String?,
        labels: [String: AnyCodable]?,
        max_order_value: Double?,
        metadata: [String: AnyCodable]?,
        min_order_value: Double?,
        name: String?,
        position: Int?,
        provider: String?,
        provider_method: String?,
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
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.countries = try container.decodeIfPresent([String: AnyCodable].self, forKey: .countries)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.fee_amount = try container.decodeIfPresent(Double.self, forKey: .fee_amount)
        self.fee_currency = try container.decodeIfPresent(String.self, forKey: .fee_currency)
        self.fee_type = try container.decodeIfPresent(String.self, forKey: .fee_type)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.max_order_value = try container.decodeIfPresent(Double.self, forKey: .max_order_value)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.min_order_value = try container.decodeIfPresent(Double.self, forKey: .min_order_value)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
        self.provider_method = try container.decodeIfPresent(String.self, forKey: .provider_method)
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
        try container.encodeIfPresent(fee_type, forKey: .fee_type)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(max_order_value, forKey: .max_order_value)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(min_order_value, forKey: .min_order_value)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(provider, forKey: .provider)
        try container.encodeIfPresent(provider_method, forKey: .provider_method)
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
            "fee_type": fee_type as Any,
            "id": id as Any,
            "kind": kind as Any,
            "labels": labels as Any,
            "max_order_value": max_order_value as Any,
            "metadata": metadata as Any,
            "min_order_value": min_order_value as Any,
            "name": name as Any,
            "position": position as Any,
            "provider": provider as Any,
            "provider_method": provider_method as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentMethod {
        return PaymentMethod(
            code: map["code"] as? String,
            countries: map["countries"] as? [String: AnyCodable],
            created_at: map["created_at"] as? String,
            description: map["description"] as? String,
            enabled: map["enabled"] as? Bool,
            fee_amount: map["fee_amount"] as? Double,
            fee_currency: map["fee_currency"] as? String,
            fee_type: map["fee_type"] as? String,
            id: map["id"] as? String,
            kind: map["kind"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            max_order_value: map["max_order_value"] as? Double,
            metadata: map["metadata"] as? [String: AnyCodable],
            min_order_value: map["min_order_value"] as? Double,
            name: map["name"] as? String,
            position: map["position"] as? Int,
            provider: map["provider"] as? String,
            provider_method: map["provider_method"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
