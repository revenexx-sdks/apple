import Foundation
import JSONCodable

/// 
open class InventoryReceiveRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
        case product_id = "product_id"
        case quantity = "quantity"
        case reason = "reason"
        case sku = "sku"
    }

    /// The goods that arrived, at most 200 in one call — a delivery, a production batch, an opening balance.
    public let items: [InventoryStockItem]?
    /// Which location took the delivery. Omitted, the `default_location_code` setting decides; a code no location carries is answered 400 rather than booked somewhere else.
    public let location_code: String?
    /// Inline single-item form: the product to move, instead of a one-entry `items` array. The two forms are equivalent — nothing downstream knows which arrived.
    public let product_id: String?
    /// Inline single-item form: how many arrived. Positive.
    public let quantity: Double?
    /// What the ledger should record about this receipt — a delivery note number, a production order. Owed only when `movement_reason_required` is 'all'; the contract does not require it, because whether it is owed is the tenant's setting and not this route's rule.
    public let reason: String?
    /// Inline single-item form: the article number to move (instead of `product_id`).
    public let sku: String?

    init(
        items: [InventoryStockItem]?,
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

        self.items = try container.decodeIfPresent([InventoryStockItem].self, forKey: .items)
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

    public static func from(map: [String: Any] ) -> InventoryReceiveRequest {
        return InventoryReceiveRequest(
            items: (map["items"] as? [[String: Any]] ?? []).map { InventoryStockItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            reason: map["reason"] as? String,
            sku: map["sku"] as? String
        )
    }
}
