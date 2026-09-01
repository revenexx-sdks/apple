import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value.
open class PriceEntryUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case price_type = "price_type"
        case product_id = "product_id"
        case quantity_min = "quantity_min"
        case sku = "sku"
        case unit = "unit"
        case unit_price = "unit_price"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
    }

    /// Free-form bag: whatever JSON object you write round-trips exactly, and this app never reads it. Its keys are yours.
    public let metadata: [String: AnyCodable]?
    /// Default 'standard'; 'on_request' is the explicit no-price marker — it STOPS resolution for this item on this list and answers "price on request" even where a cheaper list exists.
    public let price_type: RevenexxEnums.PriceEntryType?
    /// The product this rung prices. An entry needs product_id or sku — the row CHECK enforces it.
    public let product_id: String?
    /// Tier threshold (Staffelpreis): this price applies from this quantity upwards (default 1). The rungs of one item are the entries sharing its identity; the highest threshold at or below the requested quantity wins.
    public let quantity_min: Double?
    /// The article number this rung prices (alternative to product_id). Matched exactly on resolve — never normalised or case-folded.
    public let sku: String?
    /// Unit of measure the price is per — free text, neither validated nor converted here. A resolve call’s `quantity` is counted in it.
    public let unit: String?
    /// Price for ONE unit of `unit`, in the LIST’s currency and on the LIST’s tax basis — a decimal amount in major units (19.90), never minor units/cents. Stored at 4 decimals and echoed back exactly as sent (default 0).
    public let unit_price: Double?
    /// Start of this entry’s own validity (ISO 8601) — how a promo price is expressed: a second rung, live only for its window. null = open-ended.
    public let valid_from: String?
    /// End of this entry’s own validity; null = open-ended. Outside it the rung is skipped and the ladder resolves as if it were not there.
    public let valid_until: String?

    init(
        metadata: [String: AnyCodable]?,
        price_type: RevenexxEnums.PriceEntryType?,
        product_id: String?,
        quantity_min: Double?,
        sku: String?,
        unit: String?,
        unit_price: Double?,
        valid_from: String?,
        valid_until: String?
    ) {
        self.metadata = metadata
        self.price_type = price_type
        self.product_id = product_id
        self.quantity_min = quantity_min
        self.sku = sku
        self.unit = unit
        self.unit_price = unit_price
        self.valid_from = valid_from
        self.valid_until = valid_until
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        if let price_typeString = try container.decodeIfPresent(String.self, forKey: .price_type) {
            self.price_type = RevenexxEnums.PriceEntryType(rawValue: price_typeString)
        } else {
            self.price_type = nil
        }
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity_min = try container.decodeIfPresent(Double.self, forKey: .quantity_min)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.valid_from = try container.decodeIfPresent(String.self, forKey: .valid_from)
        self.valid_until = try container.decodeIfPresent(String.self, forKey: .valid_until)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(price_type?.rawValue, forKey: .price_type)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity_min, forKey: .quantity_min)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(valid_from, forKey: .valid_from)
        try container.encodeIfPresent(valid_until, forKey: .valid_until)
    }

    public func toMap() -> [String: Any] {
        return [
            "metadata": metadata as Any,
            "price_type": price_type?.rawValue as Any,
            "product_id": product_id as Any,
            "quantity_min": quantity_min as Any,
            "sku": sku as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntryUpdateRequest {
        return PriceEntryUpdateRequest(
            metadata: map["metadata"] as? [String: AnyCodable],
            price_type: map["price_type"] as? String != nil ? PriceEntryType(rawValue: map["price_type"] as! String) : nil,
            product_id: map["product_id"] as? String,
            quantity_min: map["quantity_min"] as? Double,
            sku: map["sku"] as? String,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            valid_from: map["valid_from"] as? String,
            valid_until: map["valid_until"] as? String
        )
    }
}
