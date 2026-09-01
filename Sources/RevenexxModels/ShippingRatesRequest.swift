import Foundation
import JSONCodable

/// The buyer context the checkout resolves rates for — matrix methods need their measure (weight, quantity, order value or attribute) to apply.
open class ShippingRatesRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case at = "at"
        case attributes = "attributes"
        case country = "country"
        case currency = "currency"
        case market_id = "market_id"
        case order_value = "order_value"
        case order_value_gross = "order_value_gross"
        case order_value_net = "order_value_net"
        case quantity = "quantity"
        case weight = "weight"
        case weight_unit = "weight_unit"
    }

    /// The instant to evaluate the delivery estimate at (ISO 8601). Omitted: now. Lets a storefront compute the cut-off in its own timezone.
    public let at: String?
    /// Measure values for attribute matrices, keyed by attribute NAME — the key a matrix method names in its matrix_attribute, and the value the number its tiers are matched against. Summed over the basket by the caller, not by this app. Only the key a method asks for is read; anything else in the map is carried along and ignored, and a value that is not a finite number excludes that method with a reason rather than failing the quote.
    public let attributes: [String: AnyCodable]?
    /// Destination ISO 3166-1 alpha-2 code — compared upper-cased against method and carrier country restrictions. Omitted or null: every method that restricts by country is excluded, with a reason.
    public let country: String?
    /// ISO 4217 code, echoed into the rates (default 'EUR'). Echoed, not converted: this app prices in the currency the method carries.
    public let currency: String?
    /// Buyer market for tax resolution. Omitted: the market matching `country`, else the tenant's sole market — never an arbitrary one.
    public let market_id: String?
    /// Order value (default 0) — drives order_value matrices, and free-above thresholds when no sided value is sent. Read on the basis the tenant's free_above_compares setting declares.
    public let order_value: Double?
    /// Order value including tax. Compared against free-above thresholds when free_above_compares is 'gross'.
    public let order_value_gross: Double?
    /// Order value excluding tax. Compared against free-above thresholds when free_above_compares is 'net'.
    public let order_value_net: Double?
    /// Total quantity — measure for quantity matrices.
    public let quantity: Double?
    /// Total weight — measure for weight matrices. Read in weight_unit and converted to the unit the tiers are keyed in.
    public let weight: Double?
    /// The unit `weight` is expressed in, as a CODE into the tenant's own weight units (GET /shipping/weight-units). Omitted, it is the unit this market quotes in. A unit the tenant does not keep is a 400 — a mis-read weight prices the wrong bracket silently, and guessing is worse than refusing.
    public let weight_unit: String?

    init(
        at: String?,
        attributes: [String: AnyCodable]?,
        country: String?,
        currency: String?,
        market_id: String?,
        order_value: Double?,
        order_value_gross: Double?,
        order_value_net: Double?,
        quantity: Double?,
        weight: Double?,
        weight_unit: String?
    ) {
        self.at = at
        self.attributes = attributes
        self.country = country
        self.currency = currency
        self.market_id = market_id
        self.order_value = order_value
        self.order_value_gross = order_value_gross
        self.order_value_net = order_value_net
        self.quantity = quantity
        self.weight = weight
        self.weight_unit = weight_unit
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.at = try container.decodeIfPresent(String.self, forKey: .at)
        self.attributes = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attributes)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.order_value = try container.decodeIfPresent(Double.self, forKey: .order_value)
        self.order_value_gross = try container.decodeIfPresent(Double.self, forKey: .order_value_gross)
        self.order_value_net = try container.decodeIfPresent(Double.self, forKey: .order_value_net)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.weight_unit = try container.decodeIfPresent(String.self, forKey: .weight_unit)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(at, forKey: .at)
        try container.encodeIfPresent(attributes, forKey: .attributes)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(order_value, forKey: .order_value)
        try container.encodeIfPresent(order_value_gross, forKey: .order_value_gross)
        try container.encodeIfPresent(order_value_net, forKey: .order_value_net)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(weight, forKey: .weight)
        try container.encodeIfPresent(weight_unit, forKey: .weight_unit)
    }

    public func toMap() -> [String: Any] {
        return [
            "at": at as Any,
            "attributes": attributes as Any,
            "country": country as Any,
            "currency": currency as Any,
            "market_id": market_id as Any,
            "order_value": order_value as Any,
            "order_value_gross": order_value_gross as Any,
            "order_value_net": order_value_net as Any,
            "quantity": quantity as Any,
            "weight": weight as Any,
            "weight_unit": weight_unit as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRatesRequest {
        return ShippingRatesRequest(
            at: map["at"] as? String,
            attributes: map["attributes"] as? [String: AnyCodable],
            country: map["country"] as? String,
            currency: map["currency"] as? String,
            market_id: map["market_id"] as? String,
            order_value: map["order_value"] as? Double,
            order_value_gross: map["order_value_gross"] as? Double,
            order_value_net: map["order_value_net"] as? Double,
            quantity: map["quantity"] as? Double,
            weight: map["weight"] as? Double,
            weight_unit: map["weight_unit"] as? String
        )
    }
}
