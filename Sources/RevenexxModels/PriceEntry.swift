import Foundation
import JSONCodable
import RevenexxEnums

/// One rung of one item’s quantity ladder inside one price list. The ladder IS the set of entries sharing an identity (product_id or sku); the amount is in the LIST’s currency and on the LIST’s tax basis.
open class PriceEntry: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case metadata = "metadata"
        case price_list_id = "price_list_id"
        case price_type = "price_type"
        case product_id = "product_id"
        case quantity_min = "quantity_min"
        case sku = "sku"
        case unit = "unit"
        case unit_price = "unit_price"
        case updated_at = "updated_at"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
    }

    /// When the entry was created.
    public let created_at: String?
    /// The entry itself — one rung of one item’s quantity ladder.
    public let id: String?
    /// Free-form bag, unvalidated and never read by this app: whatever JSON object you write round-trips exactly. Its keys are the integration’s own, e.g. {"source_system": "erp", "imported_batch": "2026-02-14"}.
    public let metadata: [String: AnyCodable]?
    /// The price list this entry belongs to, and therefore the currency and tax basis its amount is on. Set from the path on write.
    public let price_list_id: String?
    /// `standard` is a number. `on_request` is the explicit no-price marker: it STOPS resolution for this item on this list and answers price-on-request, even where a cheaper list exists — the list is authoritative for this buyer and it says "ask us".
    public let price_type: RevenexxEnums.PriceEntryType?
    /// The product this rung prices. An entry needs `product_id` or `sku` (a row CHECK enforces it); an entry that carries both prices whichever of the two the resolve item names.
    public let product_id: String?
    /// Lowest quantity this price applies from (Staffelpreis). The ladder for one item is the set of entries sharing its identity: the rung with the HIGHEST quantity_min at or below the requested quantity wins, and below the first rung the first rung’s price applies — a minimum order quantity belongs to the catalog, not to the ladder.
    public let quantity_min: Double?
    /// The article number this rung prices, for a price book keyed by SKU rather than by product id — matched exactly, never normalised or case-folded.
    public let sku: String?
    /// The unit of measure the price is per — ‘pcs’, ‘m’, ‘kg’, a packaging size. Free text: this app neither validates nor converts it, and the `quantity` of a resolve call is counted in it.
    public let unit: String?
    /// Price for ONE unit of `unit`, expressed in the list’s `currency` and on the list’s `tax_basis` — a decimal amount in major units (19.90 EUR), never minor units/cents. Stored at 4 decimals so a per-1000-piece price survives, and echoed back exactly as it was written; only DERIVED amounts (net, gross, line totals) are rounded to the tenant’s `price_precision`.
    public let unit_price: Double?
    /// When the entry last changed. A bulk adjust only writes the rows whose price actually moved, so this is a real "the price changed here" marker.
    public let updated_at: String?
    /// Start of this entry’s own validity; null = open-ended. This is how a promo price is expressed — a second rung for the same item and quantity, live only for its window.
    public let valid_from: String?
    /// End of this entry’s own validity; null = open-ended. Outside the window the rung is skipped and the ladder resolves as if it were not there.
    public let valid_until: String?

    init(
        created_at: String?,
        id: String?,
        metadata: [String: AnyCodable]?,
        price_list_id: String?,
        price_type: RevenexxEnums.PriceEntryType?,
        product_id: String?,
        quantity_min: Double?,
        sku: String?,
        unit: String?,
        unit_price: Double?,
        updated_at: String?,
        valid_from: String?,
        valid_until: String?
    ) {
        self.created_at = created_at
        self.id = id
        self.metadata = metadata
        self.price_list_id = price_list_id
        self.price_type = price_type
        self.product_id = product_id
        self.quantity_min = quantity_min
        self.sku = sku
        self.unit = unit
        self.unit_price = unit_price
        self.updated_at = updated_at
        self.valid_from = valid_from
        self.valid_until = valid_until
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.price_list_id = try container.decodeIfPresent(String.self, forKey: .price_list_id)
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
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.valid_from = try container.decodeIfPresent(String.self, forKey: .valid_from)
        self.valid_until = try container.decodeIfPresent(String.self, forKey: .valid_until)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(price_list_id, forKey: .price_list_id)
        try container.encodeIfPresent(price_type?.rawValue, forKey: .price_type)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity_min, forKey: .quantity_min)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(valid_from, forKey: .valid_from)
        try container.encodeIfPresent(valid_until, forKey: .valid_until)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "metadata": metadata as Any,
            "price_list_id": price_list_id as Any,
            "price_type": price_type?.rawValue as Any,
            "product_id": product_id as Any,
            "quantity_min": quantity_min as Any,
            "sku": sku as Any,
            "unit": unit as Any,
            "unit_price": unit_price as Any,
            "updated_at": updated_at as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntry {
        return PriceEntry(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            price_list_id: map["price_list_id"] as? String,
            price_type: map["price_type"] as? String != nil ? PriceEntryType(rawValue: map["price_type"] as! String) : nil,
            product_id: map["product_id"] as? String,
            quantity_min: map["quantity_min"] as? Double,
            sku: map["sku"] as? String,
            unit: map["unit"] as? String,
            unit_price: map["unit_price"] as? Double,
            updated_at: map["updated_at"] as? String,
            valid_from: map["valid_from"] as? String,
            valid_until: map["valid_until"] as? String
        )
    }
}
