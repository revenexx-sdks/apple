import Foundation
import JSONCodable

/// 
open class InventoryAvailabilityRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
    }

    /// The items to check, at most 200 in one call. A cart, a category page, a feed row — one call answers them all, which is why this route is the batch one.
    public let items: [InventoryAvailabilityItem]?
    /// Restrict the check to ONE location, by its code — the stock a click-and-collect store can promise today. Omitted, every ENABLED location is summed; a disabled one is never counted either way.
    public let location_code: String?
    /// Inline single-item form: the product to move, instead of a one-entry `items` array. The two forms are equivalent — nothing downstream knows which arrived.
    public let product_id: String?
    /// Inline single-item form: how many are wanted (default 1). It decides `orderable` and nothing else.
    public let quantity: Double?
    /// Inline single-item form: the article number to move (instead of `product_id`).
    public let sku: String?

    init(
        items: [InventoryAvailabilityItem]?,
        location_code: String?,
        product_id: String?,
        quantity: Double?,
        sku: String?
    ) {
        self.items = items
        self.location_code = location_code
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([InventoryAvailabilityItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items?.map { $0.toMap() } as Any,
            "location_code": location_code as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryAvailabilityRequest {
        return InventoryAvailabilityRequest(
            items: (map["items"] as? [[String: Any]] ?? []).map { InventoryAvailabilityItem.from(map: $0) },
            location_code: map["location_code"] as? String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String
        )
    }
}
