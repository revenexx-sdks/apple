import Foundation
import JSONCodable

/// One item and its SIGNED correction: 'product_id' or 'sku', plus a non-zero delta.
open class InventoryAdjustItem: Codable {

    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
    }

    /// The product to move, as the products app knows it. Give this OR `sku` — an item that names neither is answered 400. Matching is exact: a stock row keyed by SKU is not found by product id.
    public let product_id: String?
    /// The SIGNED correction to `on_hand`: −3 writes off three, +3 finds three. It is a delta, not the new balance. Zero is refused (400) because a correction of nothing is a mistake, not a booking — the rule is the handler's, not a database CHECK, which is why it is stated here rather than declared as a bound.
    public let quantity: Double
    /// The article number to move, when the item has no product id. Give this OR `product_id`.
    public let sku: String?

    init(
        product_id: String?,
        quantity: Double,
        sku: String?
    ) {
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decode(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encode(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryAdjustItem {
        return InventoryAdjustItem(
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as! Double,
            sku: map["sku"] as? String
        )
    }
}
