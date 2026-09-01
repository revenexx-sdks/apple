import Foundation
import JSONCodable

/// One item to check: 'product_id' or 'sku'. Checking is free of consequence — it books nothing and holds nothing.
open class InventoryAvailabilityItem: Codable {

    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
    }

    /// The product to move, as the products app knows it. Give this OR `sku` — an item that names neither is answered 400. Matching is exact: a stock row keyed by SKU is not found by product id.
    public let product_id: String?
    /// How many are wanted. It only decides `orderable`; the on_hand / reserved / available figures come back whatever it is. Omit it (or send null) to ask "is this sellable at all?", which is a check against 1.
    public let quantity: Double?
    /// The article number to move, when the item has no product id. Give this OR `product_id`.
    public let sku: String?

    init(
        product_id: String?,
        quantity: Double?,
        sku: String?
    ) {
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryAvailabilityItem {
        return InventoryAvailabilityItem(
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String
        )
    }
}
