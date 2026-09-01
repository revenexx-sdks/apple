import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value.
open class ShippingMethodUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case carrier_id = "carrier_id"
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
        case quote_above = "quote_above"
        case tax_class = "tax_class"
    }

    /// Carrier CODE, kept from before shipping_carriers existed. Looked up in the carrier table when carrier_id is not set, so an existing value keeps working and gains a tracking template; a code nobody maintains is still reported as a plain name.
    public let carrier: String?
    /// The carrier this method ships with. Wins over `carrier` and supplies the tracking template, pickup cut-off, handling time and transit days.
    public let carrier_id: String?
    /// Stable method code, unique per tenant (e.g. standard, express). What a checkout and an order line store, so it is the value every integration joins on.
    public let code: String?
    /// The countries this method may be offered into. ISO 3166-1 alpha-2 codes; null or an empty array means no restriction. Compared upper-cased, so a lower-case entry still matches. Declared as an array rather than the bare object a jsonb column derives to — this one is always a list. ANDed with the carrier's own reach.
    public let countries: [String]?
    /// ISO 4217 code (default EUR). Exactly three characters — the column says so. Echoed into a rate, never converted: this app prices in the currency the method carries.
    public let currency: String?
    /// The sentence under the name in the checkout — the delivery promise in words. Null when the name says enough.
    public let description: String?
    /// Only enabled methods are ever quoted (default false); a disabled one is reported in `excluded` rather than hidden.
    public let enabled: Bool?
    /// Transit time upper bound in calendar days. Falls back to the carrier's when null.
    public let eta_days_max: Int?
    /// Transit time lower bound in calendar days, for the checkout. Falls back to the carrier's when null.
    public let eta_days_min: Int?
    /// Free shipping at or above this order value — wins over every pricing model, including a matrix. Compared net or gross as the market's free_above_compares setting declares. Null falls back to the tenant's shop-wide free_shipping_threshold.
    public let free_above: Double?
    /// Localized display names. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let labels: [String: AnyCodable]?
    /// Attribute name for matrix_basis 'attribute' — the key the rate request's `attributes` map is read at. Free text: the set of attributes is the catalogue's, not this app's.
    public let matrix_attribute: String?
    /// The measure a matrix method prices its tiers over: total basket weight (in the market's weight unit), total item count, order value, or 'attribute' — any number the rate request carries under matrix_attribute. Null falls back to the tenant's matrix_basis_default. Ignored unless pricing_type is 'matrix'.
    public let matrix_basis: RevenexxEnums.ShippingMethodMatrixBasis?
    /// Free-form jsonb the platform never reads or validates — whatever the merchant or their integration needs to keep beside the row (a customer number with the carrier, an ERP key, a label-printer id). The shape varies BY INTEGRATION, not by anything this app knows, so no key is declared and none is reserved; the example is one plausible instance rather than a schema. A flat map of scalars is the convention, and nothing enforces it.
    public let metadata: [String: AnyCodable]?
    /// Display name shown in the checkout.
    public let name: String?
    /// Sort order in the checkout (default 0) — a rate answer is returned in this order.
    public let position: Int?
    /// The fixed price (default 0), in `currency` — ignored for 'free' and 'matrix'.
    public let price: Double?
    /// Pricing model (default 'fixed'): 'fixed' is one price for every basket, 'free' is no price at all, 'matrix' is a tiered price read off this method's rate tiers. Only 'matrix' looks at matrix_basis, quote_above and the tier table.
    public let pricing_type: RevenexxEnums.ShippingMethodPricingType?
    /// Above this MATRIX MEASURE the method carries no automatic price: it is still offered, flagged `quote_required` with a reason, and the storefront shows 'shipping on request'. For bulky or overweight freight priced by hand. Null = every measure is priced automatically.
    public let quote_above: Double?
    /// This method's own tax class, as a CODE into the buyer market's tax classes (markets.tax_classes) — never a rate. First step of the tax chain: unset falls back to the tenant's shipping_tax_class setting, then the market default. Not a foreign key and it could not be (ADR-0055); GET /shipping/tax-classes/{code}/usage is the integrity question markets asks in its place.
    public let tax_class: String?

    init(
        carrier: String?,
        carrier_id: String?,
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
        matrix_basis: RevenexxEnums.ShippingMethodMatrixBasis?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        price: Double?,
        pricing_type: RevenexxEnums.ShippingMethodPricingType?,
        quote_above: Double?,
        tax_class: String?
    ) {
        self.carrier = carrier
        self.carrier_id = carrier_id
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
        self.quote_above = quote_above
        self.tax_class = tax_class
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decodeIfPresent(String.self, forKey: .carrier)
        self.carrier_id = try container.decodeIfPresent(String.self, forKey: .carrier_id)
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
            self.matrix_basis = RevenexxEnums.ShippingMethodMatrixBasis(rawValue: matrix_basisString)
        } else {
            self.matrix_basis = nil
        }
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        if let pricing_typeString = try container.decodeIfPresent(String.self, forKey: .pricing_type) {
            self.pricing_type = RevenexxEnums.ShippingMethodPricingType(rawValue: pricing_typeString)
        } else {
            self.pricing_type = nil
        }
        self.quote_above = try container.decodeIfPresent(Double.self, forKey: .quote_above)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(carrier, forKey: .carrier)
        try container.encodeIfPresent(carrier_id, forKey: .carrier_id)
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
        try container.encodeIfPresent(quote_above, forKey: .quote_above)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "carrier_id": carrier_id as Any,
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
            "pricing_type": pricing_type?.rawValue as Any,
            "quote_above": quote_above as Any,
            "tax_class": tax_class as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingMethodUpdateRequest {
        return ShippingMethodUpdateRequest(
            carrier: map["carrier"] as? String,
            carrier_id: map["carrier_id"] as? String,
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
            pricing_type: map["pricing_type"] as? String != nil ? ShippingMethodPricingType(rawValue: map["pricing_type"] as! String) : nil,
            quote_above: map["quote_above"] as? Double,
            tax_class: map["tax_class"] as? String
        )
    }
}
