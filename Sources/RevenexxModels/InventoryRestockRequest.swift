import Foundation
import JSONCodable

/// 
open class InventoryRestockRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
        case order_ref = "order_ref"
        case product_id = "product_id"
        case quantity = "quantity"
        case reason = "reason"
        case restock = "restock"
        case sku = "sku"
    }

    /// The goods that came back, at most 200 in one call. Whether they rejoin sellable stock is `restock`, not this list.
    public let items: [InventoryStockItem]?
    /// Where the goods came back to — a returns warehouse is a location like any other. Omitted, the `default_location_code` setting decides.
    public let location_code: String?
    /// The order the goods came back from. It is written onto the ledger booking, so the return shows up in that order's stock history next to its reserve and shipment — no reservation is touched by it.
    public let order_ref: String?
    /// Inline single-item form: the product to move, instead of a one-entry `items` array. The two forms are equivalent — nothing downstream knows which arrived.
    public let product_id: String?
    /// Inline single-item form: how many came back. Positive.
    public let quantity: Double?
    /// Why the goods came back — 'wrong size', 'damaged on arrival'. Owed only when `movement_reason_required` is 'all'.
    public let reason: String?
    /// Do these goods rejoin SELLABLE stock? A merchant decision, not a fact: apparel usually restocks, hygiene articles never do, many merchants inspect first. Omit it to follow the `restock_on_return_default` setting. `false` answers `restocked: false`, moves nothing and books NOTHING — there is no movement to write, because no stock moved, and that is the branch that makes this route a 200 while its sibling `receive` is a 201.
    public let restock: Bool?
    /// Inline single-item form: the article number to move (instead of `product_id`).
    public let sku: String?

    init(
        items: [InventoryStockItem]?,
        location_code: String?,
        order_ref: String?,
        product_id: String?,
        quantity: Double?,
        reason: String?,
        restock: Bool?,
        sku: String?
    ) {
        self.items = items
        self.location_code = location_code
        self.order_ref = order_ref
        self.product_id = product_id
        self.quantity = quantity
        self.reason = reason
        self.restock = restock
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([InventoryStockItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.restock = try container.decodeIfPresent(Bool.self, forKey: .restock)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(restock, forKey: .restock)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items?.map { $0.toMap() } as Any,
            "location_code": location_code as Any,
            "order_ref": order_ref as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "reason": reason as Any,
            "restock": restock as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryRestockRequest {
        return InventoryRestockRequest(
            items: (map["items"] as? [[String: Any]] ?? []).map { InventoryStockItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            order_ref: map["order_ref"] as? String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            reason: map["reason"] as? String,
            restock: map["restock"] as? Bool,
            sku: map["sku"] as? String
        )
    }
}
