import Foundation
import JSONCodable

/// 
open class ShippingRate: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case code = "code"
        case currency = "currency"
        case description = "description"
        case eta_days_max = "eta_days_max"
        case eta_days_min = "eta_days_min"
        case free_reason = "free_reason"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case price = "price"
        case pricing_type = "pricing_type"
        case tax_class = "tax_class"
        case tax_rate = "tax_rate"
    }

    /// 
    public let carrier: String?
    /// 
    public let code: String?
    /// 
    public let currency: String?
    /// 
    public let description: String?
    /// 
    public let eta_days_max: Int?
    /// 
    public let eta_days_min: Int?
    /// 
    public let free_reason: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let position: Int?
    /// 
    public let price: Double?
    /// 
    public let pricing_type: String?
    /// Shipping method tax class (or market default).
    public let tax_class: String?
    /// Tax rate % from markets.tax_classes for this market + tax_class.
    public let tax_rate: Double?

    init(
        carrier: String?,
        code: String?,
        currency: String?,
        description: String?,
        eta_days_max: Int?,
        eta_days_min: Int?,
        free_reason: String?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        price: Double?,
        pricing_type: String?,
        tax_class: String?,
        tax_rate: Double?
    ) {
        self.carrier = carrier
        self.code = code
        self.currency = currency
        self.description = description
        self.eta_days_max = eta_days_max
        self.eta_days_min = eta_days_min
        self.free_reason = free_reason
        self.labels = labels
        self.name = name
        self.position = position
        self.price = price
        self.pricing_type = pricing_type
        self.tax_class = tax_class
        self.tax_rate = tax_rate
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decodeIfPresent(String.self, forKey: .carrier)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.eta_days_max = try container.decodeIfPresent(Int.self, forKey: .eta_days_max)
        self.eta_days_min = try container.decodeIfPresent(Int.self, forKey: .eta_days_min)
        self.free_reason = try container.decodeIfPresent(String.self, forKey: .free_reason)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.pricing_type = try container.decodeIfPresent(String.self, forKey: .pricing_type)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(carrier, forKey: .carrier)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(eta_days_max, forKey: .eta_days_max)
        try container.encodeIfPresent(eta_days_min, forKey: .eta_days_min)
        try container.encodeIfPresent(free_reason, forKey: .free_reason)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(pricing_type, forKey: .pricing_type)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "code": code as Any,
            "currency": currency as Any,
            "description": description as Any,
            "eta_days_max": eta_days_max as Any,
            "eta_days_min": eta_days_min as Any,
            "free_reason": free_reason as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "price": price as Any,
            "pricing_type": pricing_type as Any,
            "tax_class": tax_class as Any,
            "tax_rate": tax_rate as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRate {
        return ShippingRate(
            carrier: map["carrier"] as? String,
            code: map["code"] as? String,
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            eta_days_max: map["eta_days_max"] as? Int,
            eta_days_min: map["eta_days_min"] as? Int,
            free_reason: map["free_reason"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            price: map["price"] as? Double,
            pricing_type: map["pricing_type"] as? String,
            tax_class: map["tax_class"] as? String,
            tax_rate: map["tax_rate"] as? Double
        )
    }
}
