import Foundation
import JSONCodable

/// One quantity to put back into stock, named the way the inventories app wants it: by product, by sku, and how much.
open class OrderRestockPosition: Codable {

    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
    }

    /// The catalog product to restock. Null on a custom line, which is why `sku` is carried alongside it.
    public let product_id: String?
    /// How much came back on this position, in the position's own unit.
    public let quantity: Double?
    /// The article number to restock — the key a warehouse actually books against.
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

    public static func from(map: [String: Any] ) -> OrderRestockPosition {
        return OrderRestockPosition(
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String
        )
    }
}
