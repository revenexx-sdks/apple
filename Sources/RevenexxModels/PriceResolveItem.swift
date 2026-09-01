import Foundation
import JSONCodable

/// Identify by 'product_id' or 'sku' — an item without identity resolves to on_request with a per-item error rather than failing the call.
open class PriceResolveItem: Codable {

    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
    }

    /// Product to price.
    public let product_id: String?
    /// Requested quantity, counted in the entry’s `unit`. It picks the tier (the highest `quantity_min` at or below it) and multiplies into `line_total`. Default 1; a non-positive value falls back to 1.
    public let quantity: Double?
    /// SKU to price (alternative to product_id). Matched exactly against the entries’ own `sku`.
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

    public static func from(map: [String: Any] ) -> PriceResolveItem {
        return PriceResolveItem(
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            sku: map["sku"] as? String
        )
    }
}
