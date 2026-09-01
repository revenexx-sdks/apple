import Foundation
import JSONCodable

/// One entry, before and after — the row a confirmation dialog shows.
open class PriceAdjustPreviewRow: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case new_unit_price = "new_unit_price"
        case product_id = "product_id"
        case quantity_min = "quantity_min"
        case sku = "sku"
        case unit_price = "unit_price"
    }

    /// The price entry this row is about.
    public let id: String?
    /// After rounding and ending snapping, in the same currency and on the same basis. Never negative: below the lowest candidate ending it clamps to it.
    public let new_unit_price: Double?
    /// The product it prices — null when the entry is identified by SKU.
    public let product_id: String?
    /// Which rung of the ladder this is.
    public let quantity_min: Double?
    /// The SKU it prices — null when the entry is identified by product id.
    public let sku: String?
    /// Before the change, in the list’s currency and on its tax basis.
    public let unit_price: Double?

    init(
        id: String?,
        new_unit_price: Double?,
        product_id: String?,
        quantity_min: Double?,
        sku: String?,
        unit_price: Double?
    ) {
        self.id = id
        self.new_unit_price = new_unit_price
        self.product_id = product_id
        self.quantity_min = quantity_min
        self.sku = sku
        self.unit_price = unit_price
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.new_unit_price = try container.decodeIfPresent(Double.self, forKey: .new_unit_price)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity_min = try container.decodeIfPresent(Double.self, forKey: .quantity_min)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(new_unit_price, forKey: .new_unit_price)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity_min, forKey: .quantity_min)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "new_unit_price": new_unit_price as Any,
            "product_id": product_id as Any,
            "quantity_min": quantity_min as Any,
            "sku": sku as Any,
            "unit_price": unit_price as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceAdjustPreviewRow {
        return PriceAdjustPreviewRow(
            id: map["id"] as? String,
            new_unit_price: map["new_unit_price"] as? Double,
            product_id: map["product_id"] as? String,
            quantity_min: map["quantity_min"] as? Double,
            sku: map["sku"] as? String,
            unit_price: map["unit_price"] as? Double
        )
    }
}
