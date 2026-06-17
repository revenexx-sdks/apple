import Foundation
import JSONCodable

/// 
open class ResolvedPrice: Codable {

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case line_total = "line_total"
        case on_request = "on_request"
        case price_list = "price_list"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case tax_class = "tax_class"
        case tax_included = "tax_included"
        case tax_rate = "tax_rate"
        case tiers = "tiers"
        case unit_price = "unit_price"
        case unit_price_gross = "unit_price_gross"
        case unit_price_net = "unit_price_net"
    }

    /// 
    public let currency: String?
    /// 
    public let line_total: Double?
    /// true = no price for this buyer context — show &quot;price on request&quot;, never 0.
    public let on_request: Bool?
    /// 
    public let price_list: [String: AnyCodable]?
    /// 
    public let product_id: String?
    /// 
    public let quantity: Double?
    /// 
    public let sku: String?
    /// Resolved tax class code (from the product, or the market default).
    public let tax_class: String?
    /// 
    public let tax_included: Bool?
    /// Tax rate % from markets.tax_classes for this market + tax_class.
    public let tax_rate: Double?
    /// 
    public let tiers: [Any]?
    /// Stored price as-is (net or gross per tax_included). Prefer unit_price_net/unit_price_gross.
    public let unit_price: Double?
    /// Gross unit price (incl. tax).
    public let unit_price_gross: Double?
    /// Net unit price (excl. tax).
    public let unit_price_net: Double?

    init(
        currency: String?,
        line_total: Double?,
        on_request: Bool?,
        price_list: [String: AnyCodable]?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        tax_class: String?,
        tax_included: Bool?,
        tax_rate: Double?,
        tiers: [Any]?,
        unit_price: Double?,
        unit_price_gross: Double?,
        unit_price_net: Double?
    ) {
        self.currency = currency
        self.line_total = line_total
        self.on_request = on_request
        self.price_list = price_list
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.tax_class = tax_class
        self.tax_included = tax_included
        self.tax_rate = tax_rate
        self.tiers = tiers
        self.unit_price = unit_price
        self.unit_price_gross = unit_price_gross
        self.unit_price_net = unit_price_net
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.line_total = try container.decodeIfPresent(Double.self, forKey: .line_total)
        self.on_request = try container.decodeIfPresent(Bool.self, forKey: .on_request)
        self.price_list = try container.decodeIfPresent([String: AnyCodable].self, forKey: .price_list)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
        self.tax_included = try container.decodeIfPresent(Bool.self, forKey: .tax_included)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        self.tiers = try container.decodeIfPresent([Any].self, forKey: .tiers)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.unit_price_gross = try container.decodeIfPresent(Double.self, forKey: .unit_price_gross)
        self.unit_price_net = try container.decodeIfPresent(Double.self, forKey: .unit_price_net)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(line_total, forKey: .line_total)
        try container.encodeIfPresent(on_request, forKey: .on_request)
        try container.encodeIfPresent(price_list, forKey: .price_list)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
        try container.encodeIfPresent(tax_included, forKey: .tax_included)
        try container.encodeIfPresent(tax_rate, forKey: .tax_rate)
        try container.encodeIfPresent(tiers, forKey: .tiers)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(unit_price_gross, forKey: .unit_price_gross)
        try container.encodeIfPresent(unit_price_net, forKey: .unit_price_net)
    }

    public func toMap() -> [String: Any] {
        return [
            "currency": currency as Any,
            "line_total": line_total as Any,
            "on_request": on_request as Any,
            "price_list": price_list as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "tax_class": tax_class as Any,
            "tax_included": tax_included as Any,
            "tax_rate": tax_rate as Any,
            "tiers": tiers as Any,
            "unit_price": unit_price as Any,
            "unit_price_gross": unit_price_gross as Any,
            "unit_price_net": unit_price_net as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ResolvedPrice {
        return ResolvedPrice(
            currency: map["currency"] as? String,
            line_total: map["line_total"] as? Double,
            on_request: map["on_request"] as? Bool,
            price_list: map["price_list"] as? [String: AnyCodable],
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            tax_class: map["tax_class"] as? String,
            tax_included: map["tax_included"] as? Bool,
            tax_rate: map["tax_rate"] as? Double,
            tiers: map["tiers"] as? [Any],
            unit_price: map["unit_price"] as? Double,
            unit_price_gross: map["unit_price_gross"] as? Double,
            unit_price_net: map["unit_price_net"] as? Double
        )
    }
}
