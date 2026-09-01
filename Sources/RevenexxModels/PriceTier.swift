import Foundation
import JSONCodable

/// One rung of the winning list’s quantity ladder for this item.
open class PriceTier: Codable {

    enum CodingKeys: String, CodingKey {
        case quantity_min = "quantity_min"
        case unit = "unit"
        case unit_price = "unit_price"
    }

    /// The quantity this rung applies from. The rung with the highest `quantity_min` at or below the requested quantity is the one `unit_price` on the item was taken from.
    public let quantity_min: Double?
    /// Unit of measure the rung’s price is per. Absent when the entry names none.
    public let unit: String?
    /// The rung’s price for ONE unit, in the answer’s `currency` and on the item’s `tax_basis` — decimal major units, exactly as stored. Tiers are NOT tax-adjusted: only the chosen price gets `unit_price_net`/`unit_price_gross`.
    public let unit_price: Double?

    init(
        quantity_min: Double?,
        unit: String?,
        unit_price: Double?
    ) {
        self.quantity_min = quantity_min
        self.unit = unit
        self.unit_price = unit_price
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.quantity_min = try container.decodeIfPresent(Double.self, forKey: .quantity_min)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(quantity_min, forKey: .quantity_min)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
    }

    public func toMap() -> [String: Any] {
        return [
            "quantity_min": quantity_min as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceTier {
        return PriceTier(
            quantity_min: map["quantity_min"] as? Double,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double
        )
    }
}
