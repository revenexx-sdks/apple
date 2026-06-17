import Foundation
import JSONCodable

/// An item and its SIGNED correction: &#039;product_id&#039; or &#039;sku&#039;.
open class InventoryAdjustItem: Codable {

    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
    }

    /// 
    public let product_id: String?
    /// Signed delta (±on_hand) — must be non-zero.
    public let quantity: Double
    /// 
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
