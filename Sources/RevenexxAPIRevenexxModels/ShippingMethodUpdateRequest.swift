import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// Partial update — omitted fields keep their current value.
open class ShippingMethodUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case code = "code"
        case countries = "countries"
        case currency = "currency"
        case description = "description"
        case enabled = "enabled"
        case eta_days_max = "eta_days_max"
        case eta_days_min = "eta_days_min"
        case free_above = "free_above"
        case labels = "labels"
        case matrix_attribute = "matrix_attribute"
        case matrix_basis = "matrix_basis"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case price = "price"
        case pricing_type = "pricing_type"
    }

    /// Carrier anchor for the upcoming carrier connect (dynamic rates, tracking links).
    public let carrier: String?
    /// Stable method code, unique per tenant (e.g. standard, express).
    public let code: String?
    /// Allowed ISO 3166-1 alpha-2 codes; null or empty = worldwide.
    public let countries: [String]?
    /// ISO 4217 code (default EUR).
    public let currency: String?
    /// 
    public let description: String?
    /// Only enabled methods appear in rate responses (default false).
    public let enabled: Bool?
    /// Delivery-time estimate for the checkout (days, upper bound).
    public let eta_days_max: Int?
    /// Delivery-time estimate for the checkout (days, lower bound).
    public let eta_days_min: Int?
    /// Free shipping at or above this order value — wins over every pricing model.
    public let free_above: Double?
    /// Localized display names keyed by locale (e.g. {de, en}).
    public let labels: [String: AnyCodable]?
    /// Attribute name for matrix_basis &#039;attribute&#039;.
    public let matrix_attribute: String?
    /// The measure a matrix method prices over; &#039;attribute&#039; reads matrix_attribute from the rate request.
    public let matrix_basis: Revenexx API — revenexxEnums.ShippingMethodMatrixBasis?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Display name.
    public let name: String?
    /// Sort order in the checkout (default 0).
    public let position: Int?
    /// The fixed price (default 0) — ignored for &#039;free&#039; and &#039;matrix&#039;.
    public let price: Double?
    /// Pricing model (default &#039;fixed&#039;): one price, no price, or tiered over a measure.
    public let pricing_type: Revenexx API — revenexxEnums.ShippingMethodPricingType?

    init(
        carrier: String?,
        code: String?,
        countries: [String]?,
        currency: String?,
        description: String?,
        enabled: Bool?,
        eta_days_max: Int?,
        eta_days_min: Int?,
        free_above: Double?,
        labels: [String: AnyCodable]?,
        matrix_attribute: String?,
        matrix_basis: Revenexx API — revenexxEnums.ShippingMethodMatrixBasis?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        price: Double?,
        pricing_type: Revenexx API — revenexxEnums.ShippingMethodPricingType?
    ) {
        self.carrier = carrier
        self.code = code
        self.countries = countries
        self.currency = currency
        self.description = description
        self.enabled = enabled
        self.eta_days_max = eta_days_max
        self.eta_days_min = eta_days_min
        self.free_above = free_above
        self.labels = labels
        self.matrix_attribute = matrix_attribute
        self.matrix_basis = matrix_basis
        self.metadata = metadata
        self.name = name
        self.position = position
        self.price = price
        self.pricing_type = pricing_type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decodeIfPresent(String.self, forKey: .carrier)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.countries = try container.decodeIfPresent([String].self, forKey: .countries)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.eta_days_max = try container.decodeIfPresent(Int.self, forKey: .eta_days_max)
        self.eta_days_min = try container.decodeIfPresent(Int.self, forKey: .eta_days_min)
        self.free_above = try container.decodeIfPresent(Double.self, forKey: .free_above)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.matrix_attribute = try container.decodeIfPresent(String.self, forKey: .matrix_attribute)
        if let matrix_basisString = try container.decodeIfPresent(String.self, forKey: .matrix_basis) {
            self.matrix_basis = Revenexx API — revenexxEnums.ShippingMethodMatrixBasis(rawValue: matrix_basisString)
        } else {
            self.matrix_basis = nil
        }
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        if let pricing_typeString = try container.decodeIfPresent(String.self, forKey: .pricing_type) {
            self.pricing_type = Revenexx API — revenexxEnums.ShippingMethodPricingType(rawValue: pricing_typeString)
        } else {
            self.pricing_type = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(carrier, forKey: .carrier)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(countries, forKey: .countries)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(eta_days_max, forKey: .eta_days_max)
        try container.encodeIfPresent(eta_days_min, forKey: .eta_days_min)
        try container.encodeIfPresent(free_above, forKey: .free_above)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(matrix_attribute, forKey: .matrix_attribute)
        try container.encodeIfPresent(matrix_basis?.rawValue, forKey: .matrix_basis)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(pricing_type?.rawValue, forKey: .pricing_type)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "code": code as Any,
            "countries": countries as Any,
            "currency": currency as Any,
            "description": description as Any,
            "enabled": enabled as Any,
            "eta_days_max": eta_days_max as Any,
            "eta_days_min": eta_days_min as Any,
            "free_above": free_above as Any,
            "labels": labels as Any,
            "matrix_attribute": matrix_attribute as Any,
            "matrix_basis": matrix_basis?.rawValue as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "price": price as Any,
            "pricing_type": pricing_type?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingMethodUpdateRequest {
        return ShippingMethodUpdateRequest(
            carrier: map["carrier"] as? String,
            code: map["code"] as? String,
            countries: map["countries"] as? [String],
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            enabled: map["enabled"] as? Bool,
            eta_days_max: map["eta_days_max"] as? Int,
            eta_days_min: map["eta_days_min"] as? Int,
            free_above: map["free_above"] as? Double,
            labels: map["labels"] as? [String: AnyCodable],
            matrix_attribute: map["matrix_attribute"] as? String,
            matrix_basis: map["matrix_basis"] as? String != nil ? ShippingMethodMatrixBasis(rawValue: map["matrix_basis"] as! String) : nil,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            price: map["price"] as? Double,
            pricing_type: map["pricing_type"] as? String != nil ? ShippingMethodPricingType(rawValue: map["pricing_type"] as! String) : nil
        )
    }
}
