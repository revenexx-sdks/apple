import Foundation
import JSONCodable
import RevenexxEnums

/// One offerable shipping method with its computed price for this buyer context.
open class ShippingRate: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case carrier_name = "carrier_name"
        case carrier_service_level = "carrier_service_level"
        case carrier_source = "carrier_source"
        case code = "code"
        case currency = "currency"
        case delivery = "delivery"
        case description = "description"
        case eta_days_max = "eta_days_max"
        case eta_days_min = "eta_days_min"
        case free_reason = "free_reason"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case price = "price"
        case pricing_type = "pricing_type"
        case quote_reason = "quote_reason"
        case quote_required = "quote_required"
        case tax_class = "tax_class"
        case tax_rate = "tax_rate"
        case tax_source = "tax_source"
    }

    /// The carrier CODE — unchanged for every caller that already reads it. The method's carrier_id, else its `carrier` text, else the tenant's default_carrier.
    public let carrier: String?
    /// The carrier row's display name, or null when the code names no maintained carrier.
    public let carrier_name: String?
    /// The class of service this rate is, from the carrier row — a code into the tenant's service levels.
    public let carrier_service_level: String?
    /// Which step of the chain answered: 'method' (carrier_id), 'method_code' (the method's text matched a carrier), 'method_text' (it matched none), 'tenant_default' / 'tenant_default_text' (the setting, matched or not).
    public let carrier_source: RevenexxEnums.ShippingCarrierSource?
    /// Stable method code, unique per tenant (e.g. standard, express). What a checkout and an order line store, so it is the value every integration joins on.
    public let code: String?
    /// ISO 4217 code (default EUR). Exactly three characters — the column says so. Echoed into a rate, never converted: this app prices in the currency the method carries.
    public let currency: String?
    /// The delivery window a checkout can print. Calendar days, cut-off evaluated in UTC (send `at` to control the instant).
    public let delivery: ShippingDeliveryEstimate?
    /// The sentence under the name in the checkout — the delivery promise in words. Null when the name says enough.
    public let description: String?
    /// Transit time upper bound in calendar days, as applied: the method's own, else the carrier's.
    public let eta_days_max: Int?
    /// Transit time lower bound in calendar days, as applied: the method's own, else the carrier's.
    public let eta_days_min: Int?
    /// Only when a free-above threshold applied. Names the compared value AND its basis (net or gross), and says whether the threshold was the method's own or shop-wide — the free-shipping promise is a common dispute and this is the sentence that settles it.
    public let free_reason: String?
    /// Localized display names. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let labels: [String: AnyCodable]?
    /// Display name shown in the checkout.
    public let name: String?
    /// Sort order in the checkout (default 0) — a rate answer is returned in this order.
    public let position: Int?
    /// The shipping fee for this basket, in `currency`, rounded to two decimals — 0 when a free-above threshold or a 'free' method applied. NULL when `quote_required` is true: the price is unknown, not zero, and a checkout must not add 0.00 for it.
    public let price: Double?
    /// Pricing model (default 'fixed'): 'fixed' is one price for every basket, 'free' is no price at all, 'matrix' is a tiered price read off this method's rate tiers. Only 'matrix' looks at matrix_basis, quote_above and the tier table.
    public let pricing_type: RevenexxEnums.ShippingRatePricingType?
    /// Only when quote_required — the measure and the threshold it exceeded, so an operator pricing it by hand can see what triggered the referral.
    public let quote_reason: String?
    /// True when the matrix measure is above the method's quote_above threshold: the method is still offered, carries no price, and the storefront shows 'shipping on request'. The order is placed without a computed shipping fee.
    public let quote_required: Bool?
    /// The tax class this rate was taxed under, as a code in markets.tax_classes — the method's own, the tenant's shipping_tax_class, or the market's default, whichever answered. Null means unresolved, not untaxed.
    public let tax_class: String?
    /// The rate in percent from markets.tax_classes for this market and tax_class — 19 means 19 %. Null means UNKNOWN, never 0: read `tax.resolved` before treating a missing rate as tax-free.
    public let tax_rate: Double?
    /// Which step of the chain supplied the rate: the method's own class, the tenant's shipping_tax_class, the market default, or the tenant's default_shipping_tax_rate. Null means unknown, NOT untaxed.
    public let tax_source: RevenexxEnums.ShippingTaxSource?

    init(
        carrier: String?,
        carrier_name: String?,
        carrier_service_level: String?,
        carrier_source: RevenexxEnums.ShippingCarrierSource?,
        code: String?,
        currency: String?,
        delivery: ShippingDeliveryEstimate?,
        description: String?,
        eta_days_max: Int?,
        eta_days_min: Int?,
        free_reason: String?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        price: Double?,
        pricing_type: RevenexxEnums.ShippingRatePricingType?,
        quote_reason: String?,
        quote_required: Bool?,
        tax_class: String?,
        tax_rate: Double?,
        tax_source: RevenexxEnums.ShippingTaxSource?
    ) {
        self.carrier = carrier
        self.carrier_name = carrier_name
        self.carrier_service_level = carrier_service_level
        self.carrier_source = carrier_source
        self.code = code
        self.currency = currency
        self.delivery = delivery
        self.description = description
        self.eta_days_max = eta_days_max
        self.eta_days_min = eta_days_min
        self.free_reason = free_reason
        self.labels = labels
        self.name = name
        self.position = position
        self.price = price
        self.pricing_type = pricing_type
        self.quote_reason = quote_reason
        self.quote_required = quote_required
        self.tax_class = tax_class
        self.tax_rate = tax_rate
        self.tax_source = tax_source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decodeIfPresent(String.self, forKey: .carrier)
        self.carrier_name = try container.decodeIfPresent(String.self, forKey: .carrier_name)
        self.carrier_service_level = try container.decodeIfPresent(String.self, forKey: .carrier_service_level)
        if let carrier_sourceString = try container.decodeIfPresent(String.self, forKey: .carrier_source) {
            self.carrier_source = RevenexxEnums.ShippingCarrierSource(rawValue: carrier_sourceString)
        } else {
            self.carrier_source = nil
        }
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.delivery = try container.decodeIfPresent(ShippingDeliveryEstimate.self, forKey: .delivery)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.eta_days_max = try container.decodeIfPresent(Int.self, forKey: .eta_days_max)
        self.eta_days_min = try container.decodeIfPresent(Int.self, forKey: .eta_days_min)
        self.free_reason = try container.decodeIfPresent(String.self, forKey: .free_reason)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        if let pricing_typeString = try container.decodeIfPresent(String.self, forKey: .pricing_type) {
            self.pricing_type = RevenexxEnums.ShippingRatePricingType(rawValue: pricing_typeString)
        } else {
            self.pricing_type = nil
        }
        self.quote_reason = try container.decodeIfPresent(String.self, forKey: .quote_reason)
        self.quote_required = try container.decodeIfPresent(Bool.self, forKey: .quote_required)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        if let tax_sourceString = try container.decodeIfPresent(String.self, forKey: .tax_source) {
            self.tax_source = RevenexxEnums.ShippingTaxSource(rawValue: tax_sourceString)
        } else {
            self.tax_source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(carrier, forKey: .carrier)
        try container.encodeIfPresent(carrier_name, forKey: .carrier_name)
        try container.encodeIfPresent(carrier_service_level, forKey: .carrier_service_level)
        try container.encodeIfPresent(carrier_source?.rawValue, forKey: .carrier_source)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(delivery, forKey: .delivery)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(eta_days_max, forKey: .eta_days_max)
        try container.encodeIfPresent(eta_days_min, forKey: .eta_days_min)
        try container.encodeIfPresent(free_reason, forKey: .free_reason)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(pricing_type?.rawValue, forKey: .pricing_type)
        try container.encodeIfPresent(quote_reason, forKey: .quote_reason)
        try container.encodeIfPresent(quote_required, forKey: .quote_required)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(tax_source?.rawValue, forKey: .tax_source)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "carrier_name": carrier_name as Any,
            "carrier_service_level": carrier_service_level as Any,
            "carrier_source": carrier_source?.rawValue as Any,
            "code": code as Any,
            "currency": currency as Any,
            "delivery": delivery?.toMap() as Any,
            "description": description as Any,
            "eta_days_max": eta_days_max as Any,
            "eta_days_min": eta_days_min as Any,
            "free_reason": free_reason as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "price": price as Any,
            "pricing_type": pricing_type?.rawValue as Any,
            "quote_reason": quote_reason as Any,
            "quote_required": quote_required as Any,
            "tax_class": tax_class as Any,
            "tax_rate": tax_rate as Any,
            "tax_source": tax_source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRate {
        return ShippingRate(
            carrier: map["carrier"] as? String,
            carrier_name: map["carrier_name"] as? String,
            carrier_service_level: map["carrier_service_level"] as? String,
            carrier_source: map["carrier_source"] as? String != nil ? ShippingCarrierSource(rawValue: map["carrier_source"] as! String) : nil,
            code: map["code"] as? String,
            currency: map["currency"] as? String,
            delivery: ShippingDeliveryEstimate.from(map: map["delivery"] as! [String: Any]),
            description: map["description"] as? String,
            eta_days_max: map["eta_days_max"] as? Int,
            eta_days_min: map["eta_days_min"] as? Int,
            free_reason: map["free_reason"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            price: map["price"] as? Double,
            pricing_type: map["pricing_type"] as? String != nil ? ShippingRatePricingType(rawValue: map["pricing_type"] as! String) : nil,
            quote_reason: map["quote_reason"] as? String,
            quote_required: map["quote_required"] as? Bool,
            tax_class: map["tax_class"] as? String,
            tax_rate: map["tax_rate"] as? Double,
            tax_source: map["tax_source"] as? String != nil ? ShippingTaxSource(rawValue: map["tax_source"] as! String) : nil
        )
    }
}
