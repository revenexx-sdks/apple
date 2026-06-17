import Foundation
import JSONCodable

/// 
open class EligiblePaymentMethod: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case currency = "currency"
        case description = "description"
        case fee = "fee"
        case fee_type = "fee_type"
        case kind = "kind"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case provider = "provider"
    }

    /// 
    public let code: String?
    /// 
    public let currency: String?
    /// 
    public let description: String?
    /// 
    public let fee: Double?
    /// 
    public let fee_type: String?
    /// 
    public let kind: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let position: Int?
    /// 
    public let provider: String?

    init(
        code: String?,
        currency: String?,
        description: String?,
        fee: Double?,
        fee_type: String?,
        kind: String?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        provider: String?
    ) {
        self.code = code
        self.currency = currency
        self.description = description
        self.fee = fee
        self.fee_type = fee_type
        self.kind = kind
        self.labels = labels
        self.name = name
        self.position = position
        self.provider = provider
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.fee = try container.decodeIfPresent(Double.self, forKey: .fee)
        self.fee_type = try container.decodeIfPresent(String.self, forKey: .fee_type)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.provider = try container.decodeIfPresent(String.self, forKey: .provider)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(fee, forKey: .fee)
        try container.encodeIfPresent(fee_type, forKey: .fee_type)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(provider, forKey: .provider)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "currency": currency as Any,
            "description": description as Any,
            "fee": fee as Any,
            "fee_type": fee_type as Any,
            "kind": kind as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "provider": provider as Any
        ]
    }

    public static func from(map: [String: Any] ) -> EligiblePaymentMethod {
        return EligiblePaymentMethod(
            code: map["code"] as? String,
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            fee: map["fee"] as? Double,
            fee_type: map["fee_type"] as? String,
            kind: map["kind"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            provider: map["provider"] as? String
        )
    }
}
