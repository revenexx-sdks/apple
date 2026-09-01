import Foundation
import JSONCodable

/// 
open class InventoryAdjustRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
        case product_id = "product_id"
        case quantity = "quantity"
        case reason = "reason"
        case sku = "sku"
    }

    /// The corrections, at most 200 in one call — a stocktake, breakage, shrinkage. Quantities are SIGNED deltas, not new balances.
    public let items: [InventoryAdjustItem]?
    /// Which location is being corrected. Omitted, the `default_location_code` setting decides. A correction is per location: the same SKU in two warehouses is two corrections.
    public let location_code: String?
    /// Inline single-item form: the product to move, instead of a one-entry `items` array. The two forms are equivalent — nothing downstream knows which arrived.
    public let product_id: String?
    /// Inline single-item form: the SIGNED correction (negative writes stock off, positive finds it). Non-zero.
    public let quantity: Double?
    /// Why the stock is being corrected — this is the audit trail a stocktake leaves behind. Owed unless `movement_reason_required` is 'none' (its default, 'adjustments', asks for one exactly here); missing where it is owed, the call is 400.
    public let reason: String?
    /// Inline single-item form: the article number to move (instead of `product_id`).
    public let sku: String?

    init(
        items: [InventoryAdjustItem]?,
        location_code: String?,
        product_id: String?,
        quantity: Double?,
        reason: String?,
        sku: String?
    ) {
        self.items = items
        self.location_code = location_code
        self.product_id = product_id
        self.quantity = quantity
        self.reason = reason
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([InventoryAdjustItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items?.map { $0.toMap() } as Any,
            "location_code": location_code as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "reason": reason as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryAdjustRequest {
        return InventoryAdjustRequest(
            items: (map["items"] as? [[String: Any]] ?? []).map { InventoryAdjustItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            reason: map["reason"] as? String,
            sku: map["sku"] as? String
        )
    }
}
