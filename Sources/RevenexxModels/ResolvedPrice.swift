import Foundation
import JSONCodable
import RevenexxEnums

/// What one item costs this buyer, and which list said so.
open class ResolvedPrice: Codable {

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case error = "error"
        case line_total = "line_total"
        case on_request = "on_request"
        case on_request_reason = "on_request_reason"
        case price_list = "price_list"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case tax_basis = "tax_basis"
        case tax_basis_source = "tax_basis_source"
        case tax_class = "tax_class"
        case tax_included = "tax_included"
        case tax_rate = "tax_rate"
        case tiers = "tiers"
        case unit_price = "unit_price"
        case unit_price_gross = "unit_price_gross"
        case unit_price_net = "unit_price_net"
    }

    /// ISO 4217 currency of every amount on this item. Always the winning list’s currency, which always equals the call’s top-level `currency` — resolution only considers lists that match it, so a list and its answer can never disagree. null on an on-request item.
    public let currency: String?
    /// Present ONLY on an item that named neither `product_id` nor `sku`, and always with this exact text. The call still answers 200 and the item comes back on_request, because one malformed line must not cost a whole cart its prices.
    public let error: String?
    /// `unit_price × quantity`, on the SAME basis as `unit_price` (so net if the list is net) and rounded to `basis.price_precision`. Not a tax-adjusted total — a cart computes its own from the net/gross pair.
    public let line_total: Double?
    /// true = no price for this buyer context — show "price on request", never 0.
    public let on_request: Bool?
    /// Why there is no price: nothing prices it, a list marks it on-request, the tenant hides prices from anonymous buyers, or the item named neither product_id nor sku.
    public let on_request_reason: RevenexxEnums.PriceOnRequestReason?
    /// The list that priced this item — null when nothing did. On an `on_request_entry` answer it is the list that said "ask us".
    public let price_list: [String: AnyCodable]?
    /// Echo of the requested `product_id` — null when the item was identified by SKU.
    public let product_id: String?
    /// The quantity this answer was computed for: what you sent, or 1 where you sent nothing or a non-positive value. It selects the tier and multiplies into `line_total`.
    public let quantity: Double?
    /// Echo of the requested `sku` — null when the item was identified by product id.
    public let sku: String?
    /// Whether the stored amount is net or gross. THE fact a price cannot be without.
    public let tax_basis: RevenexxEnums.PriceTaxBasis?
    /// Who decided it: the list's own tax_basis, a legacy tax_included=true on the list, or the tenant's tax_inclusive_default setting.
    public let tax_basis_source: RevenexxEnums.PriceTaxBasisSource?
    /// The tax class code that produced `tax_rate`: the product’s own class where the products app knows one, otherwise the buyer market’s default class. The codes are the tenant’s, defined in `markets.tax_classes` — conventionally `standard` and `reduced`. null when tax could not be resolved.
    public let tax_class: String?
    /// Whether unit_price already contains tax. Never null on a priced item — it is `tax_basis` as a boolean, kept for existing callers.
    public let tax_included: Bool?
    /// Tax rate as a PERCENTAGE (19 means 19 %, not 0.19), read from `markets.tax_classes` for this market and `tax_class`. null means UNKNOWN — a checkout must be able to tell that apart from a genuine 0 %.
    public let tax_rate: Double?
    /// The FULL quantity ladder the winning list holds for this item, ascending by `quantity_min` — what a PDP renders as a tier table. Empty on an on-request item.
    public let tiers: [PriceTier]?
    /// Price for ONE unit, in `currency` and on the basis `tax_basis` names — a decimal amount in major units (19.90 EUR), never minor units/cents. It is the stored rung exactly as a merchant typed it, unrounded. Do not display it without reading `tax_basis`; prefer `unit_price_net`/`unit_price_gross`, which are unambiguous.
    public let unit_price: Double?
    /// Unit price INCLUDING tax, in `currency`, rounded to `basis.price_precision` under `basis.rounding_mode`. Derived from `unit_price` and `tax_rate` in whichever direction `tax_basis` requires. Present only when `tax.resolved` is true.
    public let unit_price_gross: Double?
    /// Unit price EXCLUDING tax, in `currency`, rounded to `basis.price_precision` under `basis.rounding_mode`. Present only when `tax.resolved` is true — null means the rate is unknown, not that there is no tax.
    public let unit_price_net: Double?

    init(
        currency: String?,
        error: String?,
        line_total: Double?,
        on_request: Bool?,
        on_request_reason: RevenexxEnums.PriceOnRequestReason?,
        price_list: [String: AnyCodable]?,
        product_id: String?,
        quantity: Double?,
        sku: String?,
        tax_basis: RevenexxEnums.PriceTaxBasis?,
        tax_basis_source: RevenexxEnums.PriceTaxBasisSource?,
        tax_class: String?,
        tax_included: Bool?,
        tax_rate: Double?,
        tiers: [PriceTier]?,
        unit_price: Double?,
        unit_price_gross: Double?,
        unit_price_net: Double?
    ) {
        self.currency = currency
        self.error = error
        self.line_total = line_total
        self.on_request = on_request
        self.on_request_reason = on_request_reason
        self.price_list = price_list
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.tax_basis = tax_basis
        self.tax_basis_source = tax_basis_source
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
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
        self.line_total = try container.decodeIfPresent(Double.self, forKey: .line_total)
        self.on_request = try container.decodeIfPresent(Bool.self, forKey: .on_request)
        if let on_request_reasonString = try container.decodeIfPresent(String.self, forKey: .on_request_reason) {
            self.on_request_reason = RevenexxEnums.PriceOnRequestReason(rawValue: on_request_reasonString)
        } else {
            self.on_request_reason = nil
        }
        self.price_list = try container.decodeIfPresent([String: AnyCodable].self, forKey: .price_list)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        if let tax_basisString = try container.decodeIfPresent(String.self, forKey: .tax_basis) {
            self.tax_basis = RevenexxEnums.PriceTaxBasis(rawValue: tax_basisString)
        } else {
            self.tax_basis = nil
        }
        if let tax_basis_sourceString = try container.decodeIfPresent(String.self, forKey: .tax_basis_source) {
            self.tax_basis_source = RevenexxEnums.PriceTaxBasisSource(rawValue: tax_basis_sourceString)
        } else {
            self.tax_basis_source = nil
        }
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
        self.tax_included = try container.decodeIfPresent(Bool.self, forKey: .tax_included)
        self.tax_rate = try container.decodeIfPresent(Double.self, forKey: .tax_rate)
        self.tiers = try container.decodeIfPresent([PriceTier].self, forKey: .tiers)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.unit_price_gross = try container.decodeIfPresent(Double.self, forKey: .unit_price_gross)
        self.unit_price_net = try container.decodeIfPresent(Double.self, forKey: .unit_price_net)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(line_total, forKey: .line_total)
        try container.encodeIfPresent(on_request, forKey: .on_request)
        try container.encodeIfPresent(on_request_reason?.rawValue, forKey: .on_request_reason)
        try container.encodeIfPresent(price_list, forKey: .price_list)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(tax_basis?.rawValue, forKey: .tax_basis)
        try container.encodeIfPresent(tax_basis_source?.rawValue, forKey: .tax_basis_source)
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
            "error": error as Any,
            "line_total": line_total as Any,
            "on_request": on_request as Any,
            "on_request_reason": on_request_reason?.rawValue as Any,
            "price_list": price_list as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "tax_basis": tax_basis?.rawValue as Any,
            "tax_basis_source": tax_basis_source?.rawValue as Any,
            "tax_class": tax_class as Any,
            "tax_included": tax_included as Any,
            "tax_rate": tax_rate as Any,
            "tiers": tiers?.map { $0.toMap() } as Any,
            "unit_price": unit_price as Any,
            "unit_price_gross": unit_price_gross as Any,
            "unit_price_net": unit_price_net as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ResolvedPrice {
        return ResolvedPrice(
            currency: map["currency"] as? String,
            error: map["error"] as? String,
            line_total: map["line_total"] as? Double,
            on_request: map["on_request"] as? Bool,
            on_request_reason: map["on_request_reason"] as? String != nil ? PriceOnRequestReason(rawValue: map["on_request_reason"] as! String) : nil,
            price_list: map["price_list"] as? [String: AnyCodable],
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String,
            tax_basis: map["tax_basis"] as? String != nil ? PriceTaxBasis(rawValue: map["tax_basis"] as! String) : nil,
            tax_basis_source: map["tax_basis_source"] as? String != nil ? PriceTaxBasisSource(rawValue: map["tax_basis_source"] as! String) : nil,
            tax_class: map["tax_class"] as? String,
            tax_included: map["tax_included"] as? Bool,
            tax_rate: map["tax_rate"] as? Double,
            tiers: (map["tiers"] as? [[String: Any]] ?? []).map { PriceTier.from(map: $0) },
            unit_price: map["unit_price"] as? Double,
            unit_price_gross: map["unit_price_gross"] as? Double,
            unit_price_net: map["unit_price_net"] as? Double
        )
    }
}
