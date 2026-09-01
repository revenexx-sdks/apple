import Foundation
import JSONCodable

/// 
open class InventoryReserveRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case expires_at = "expires_at"
        case items = "items"
        case location_code = "location_code"
        case order_ref = "order_ref"
        case product_id = "product_id"
        case quantity = "quantity"
        case ship_to = "ship_to"
        case sku = "sku"
    }

    /// When this hold lapses. The sweeper — POST /inventories/reservations/sweep, and the 'expire-reservations' schedule that runs it every 15 minutes — releases everything past this moment exactly as a cancellation would, so an abandoned checkout stops holding stock on its own. Null means the row named no deadline: it is swept on its AGE instead once `reservation_ttl_minutes` is above 0, which is what makes turning that setting on retroactive. Omit it to let the `reservation_ttl_minutes` setting stamp one (0 — its default — means no deadline at all); send one to hold this order for a window of its own, e.g. a quote that stands until Friday.
    public let expires_at: String?
    /// The items to hold, at most 200 in one call — a whole cart in one request. The call is planned before anything is written, so either every item is placed or nothing is.
    public let items: [InventoryStockItem]?
    /// Where a BACKORDERED item is booked when no location holds a stock row for it at all — the last fallback, not the allocator: which location serves an item that IS in stock comes from `allocation_strategy`. Omitted, the `default_location_code` setting decides.
    public let location_code: String?
    /// The order this hold belongs to. The caller supplies it — this app mints nothing — and it is the handle POST /inventories/release and POST /inventories/commit act on, so it has to be the same string the order carries elsewhere. At least one character (CHECK `length(order_ref) > 0`). Not unique: an order holds one reservation per item, and they are released or committed together. Reserving twice under the same reference ADDS holds rather than replacing them — release first if you mean to replace.
    public let order_ref: String
    /// Inline single-item form: the product to move, instead of a one-entry `items` array. The two forms are equivalent — nothing downstream knows which arrived.
    public let product_id: String?
    /// Inline single-item form: how many to hold. Positive — the hold is expressed as a positive reservation, while the ledger booking it writes carries the negative.
    public let quantity: Double?
    /// Where the order is going. Read ONLY when the tenant's `allocation_strategy` is 'nearest' — under 'priority' or 'single_location' it is accepted and ignored, so sending it is never wrong, it is just not always heard.
    public let ship_to: InventoryShipTo?
    /// Inline single-item form: the article number to move (instead of `product_id`).
    public let sku: String?

    init(
        expires_at: String?,
        items: [InventoryStockItem]?,
        location_code: String?,
        order_ref: String,
        product_id: String?,
        quantity: Double?,
        ship_to: InventoryShipTo?,
        sku: String?
    ) {
        self.expires_at = expires_at
        self.items = items
        self.location_code = location_code
        self.order_ref = order_ref
        self.product_id = product_id
        self.quantity = quantity
        self.ship_to = ship_to
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.expires_at = try container.decodeIfPresent(String.self, forKey: .expires_at)
        self.items = try container.decodeIfPresent([InventoryStockItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.order_ref = try container.decode(String.self, forKey: .order_ref)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.ship_to = try container.decodeIfPresent(InventoryShipTo.self, forKey: .ship_to)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(expires_at, forKey: .expires_at)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encode(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(ship_to, forKey: .ship_to)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "expires_at": expires_at as Any,
            "items": items?.map { $0.toMap() } as Any,
            "location_code": location_code as Any,
            "order_ref": order_ref as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "ship_to": ship_to?.toMap() as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryReserveRequest {
        return InventoryReserveRequest(
            expires_at: map["expires_at"] as? String,
            items: (map["items"] as? [[String: Any]] ?? []).map { InventoryStockItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            order_ref: map["order_ref"] as! String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            ship_to: InventoryShipTo.from(map: map["ship_to"] as! [String: Any]),
            sku: map["sku"] as? String
        )
    }
}
