import Foundation
import JSONCodable
import RevenexxEnums

/// The quantity ladder (Staffelpreise) for ONE item, generated instead of typed: a price at the first tier and a discount compounded per tier. Identify the item with 'product_id' or 'sku'.
open class PriceEntriesLadderRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case base_price = "base_price"
        case discount_percent = "discount_percent"
        case product_id = "product_id"
        case quantities = "quantities"
        case replace = "replace"
        case rounding = "rounding"
        case sku = "sku"
        case unit = "unit"
    }

    /// Price for ONE unit at the FIRST tier, in the list’s currency and on the list’s tax basis — a decimal amount in major units (19.90), never minor units/cents.
    public let base_price: Double
    /// Discount applied per tier, COMPOUNDED down the ladder rather than off the base price: 5 gives 19.90 / 18.91 / 17.96. Default 0.
    public let discount_percent: Double?
    /// The item the ladder prices.
    public let product_id: String?
    /// Tier thresholds, ascending — an array of numbers or a comma-separated string ('1, 10, 50'). Duplicates are collapsed and the set is sorted. Default [1, 10, 50], at most 50 tiers.
    public let quantities: [Double]?
    /// Default true: the item's existing entries in this list are removed first, so the ladder IS the ladder. false appends.
    public let replace: Bool?
    /// Ending the computed prices snap to (nearest match). Omit to use the tenant's bulk_adjust_rounding setting.
    public let rounding: RevenexxEnums.PriceEndingRule?
    /// The item the ladder prices (alternative to product_id).
    public let sku: String?
    /// Unit of measure carried onto every generated tier. Free text, neither validated nor converted.
    public let unit: String?

    init(
        base_price: Double,
        discount_percent: Double?,
        product_id: String?,
        quantities: [Double]?,
        replace: Bool?,
        rounding: RevenexxEnums.PriceEndingRule?,
        sku: String?,
        unit: String?
    ) {
        self.base_price = base_price
        self.discount_percent = discount_percent
        self.product_id = product_id
        self.quantities = quantities
        self.replace = replace
        self.rounding = rounding
        self.sku = sku
        self.unit = unit
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.base_price = try container.decode(Double.self, forKey: .base_price)
        self.discount_percent = try container.decodeIfPresent(Double.self, forKey: .discount_percent)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantities = try container.decodeIfPresent([Double].self, forKey: .quantities)
        self.replace = try container.decodeIfPresent(Bool.self, forKey: .replace)
        if let roundingString = try container.decodeIfPresent(String.self, forKey: .rounding) {
            self.rounding = RevenexxEnums.PriceEndingRule(rawValue: roundingString)
        } else {
            self.rounding = nil
        }
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(base_price, forKey: .base_price)
        try container.encodeIfPresent(discount_percent, forKey: .discount_percent)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantities, forKey: .quantities)
        try container.encodeIfPresent(replace, forKey: .replace)
        try container.encodeIfPresent(rounding?.rawValue, forKey: .rounding)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(unit, forKey: .unit)
    }

    public func toMap() -> [String: Any] {
        return [
            "base_price": base_price as Any,
            "discount_percent": discount_percent as Any,
            "product_id": product_id as Any,
            "quantities": quantities as Any,
            "replace": replace as Any,
            "rounding": rounding?.rawValue as Any,
            "sku": sku as Any,
            "unit": unit as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesLadderRequest {
        return PriceEntriesLadderRequest(
            base_price: map["base_price"] as! Double,
            discount_percent: map["discount_percent"] as? Double,
            product_id: map["product_id"] as? String,
            quantities: map["quantities"] as? [Double],
            replace: map["replace"] as? Bool,
            rounding: map["rounding"] as? String != nil ? PriceEndingRule(rawValue: map["rounding"] as! String) : nil,
            sku: map["sku"] as? String,
            unit: map["unit"] as? String
        )
    }
}
