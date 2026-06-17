import Foundation
import JSONCodable

/// The buyer context the checkout resolves rates for — matrix methods need their measure (weight, quantity, order value or attribute) to apply.
open class ShippingRatesRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case attributes = "attributes"
        case country = "country"
        case currency = "currency"
        case market_id = "market_id"
        case order_value = "order_value"
        case quantity = "quantity"
        case weight = "weight"
    }

    /// Measure values for attribute matrices, keyed by attribute name.
    public let attributes: [String: AnyCodable]?
    /// Destination ISO 3166-1 alpha-2 code — checked against method country restrictions.
    public let country: String?
    /// Echoed into the rates (default &#039;EUR&#039;).
    public let currency: String?
    /// Buyer market for tax resolution (else inferred from country, else first market).
    public let market_id: String?
    /// Order value (default 0) — drives free-above thresholds and order_value matrices.
    public let order_value: Double?
    /// Total quantity — measure for quantity matrices.
    public let quantity: Double?
    /// Total weight — measure for weight matrices.
    public let weight: Double?

    init(
        attributes: [String: AnyCodable]?,
        country: String?,
        currency: String?,
        market_id: String?,
        order_value: Double?,
        quantity: Double?,
        weight: Double?
    ) {
        self.attributes = attributes
        self.country = country
        self.currency = currency
        self.market_id = market_id
        self.order_value = order_value
        self.quantity = quantity
        self.weight = weight
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attributes = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attributes)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.order_value = try container.decodeIfPresent(Double.self, forKey: .order_value)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attributes, forKey: .attributes)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(order_value, forKey: .order_value)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(weight, forKey: .weight)
    }

    public func toMap() -> [String: Any] {
        return [
            "attributes": attributes as Any,
            "country": country as Any,
            "currency": currency as Any,
            "market_id": market_id as Any,
            "order_value": order_value as Any,
            "quantity": quantity as Any,
            "weight": weight as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRatesRequest {
        return ShippingRatesRequest(
            attributes: map["attributes"] as? [String: AnyCodable],
            country: map["country"] as? String,
            currency: map["currency"] as? String,
            market_id: map["market_id"] as? String,
            order_value: map["order_value"] as? Double,
            quantity: map["quantity"] as? Double,
            weight: map["weight"] as? Double
        )
    }
}
