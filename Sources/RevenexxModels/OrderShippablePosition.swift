import Foundation
import JSONCodable

/// One order position with the quantity that may still be shipped, and the three numbers that quantity is made of. Every position of the order is here, including the ones with nothing left open — a dialog needs to show a fully shipped line as fully shipped, not omit it.
open class OrderShippablePosition: Codable {

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case order_item_id = "order_item_id"
        case position = "position"
        case product_id = "product_id"
        case quantity = "quantity"
        case quantity_cancelled = "quantity_cancelled"
        case quantity_open = "quantity_open"
        case quantity_shipped = "quantity_shipped"
        case sku = "sku"
        case unit = "unit"
    }

    /// The article name as it stood at place-time, frozen. Falls back to the sku when the caller sent none — a position always reads as something.
    public let name: String?
    /// The position, by the id a positions[] payload names it with. This is what POST /orders/{id}/ship expects — copy it, do not construct it.
    public let order_item_id: String?
    /// The line number a human reads, and what the order is sorted by. Numbered in steps of the range's position_step (10, 20, 30) unless the caller set it explicitly — the gap is what lets a line be inserted later without renumbering.
    public let position: Int?
    /// The catalog product this line was taken from (the products app). Null on a custom line, and it stays a reference — the position keeps working after the product is retired.
    public let product_id: String?
    /// How much was ORDERED on this position. Unchanged by anything that happens afterwards.
    public let quantity: Double?
    /// How much was cancelled and will never go out.
    public let quantity_cancelled: Double?
    /// quantity − shipped − cancelled: the budget POST /orders/{id}/ship guards this position against, and the largest quantity it will accept. Zero means the line is done.
    public let quantity_open: Double?
    /// How much has already gone out.
    public let quantity_shipped: Double?
    /// The article number as it stood at place-time, frozen with the rest of the line. The value an ERP and a warehouse both join on, and the one field a picker reads. Null only on a line that never had one.
    public let sku: String?
    /// The unit the quantity is counted in — piece, metre, kilogram, package. Free text as the catalog carries it; this app does no conversion.
    public let unit: String?

    init(
        name: String?,
        order_item_id: String?,
        position: Int?,
        product_id: String?,
        quantity: Double?,
        quantity_cancelled: Double?,
        quantity_open: Double?,
        quantity_shipped: Double?,
        sku: String?,
        unit: String?
    ) {
        self.name = name
        self.order_item_id = order_item_id
        self.position = position
        self.product_id = product_id
        self.quantity = quantity
        self.quantity_cancelled = quantity_cancelled
        self.quantity_open = quantity_open
        self.quantity_shipped = quantity_shipped
        self.sku = sku
        self.unit = unit
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.order_item_id = try container.decodeIfPresent(String.self, forKey: .order_item_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.quantity_cancelled = try container.decodeIfPresent(Double.self, forKey: .quantity_cancelled)
        self.quantity_open = try container.decodeIfPresent(Double.self, forKey: .quantity_open)
        self.quantity_shipped = try container.decodeIfPresent(Double.self, forKey: .quantity_shipped)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(order_item_id, forKey: .order_item_id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(quantity_cancelled, forKey: .quantity_cancelled)
        try container.encodeIfPresent(quantity_open, forKey: .quantity_open)
        try container.encodeIfPresent(quantity_shipped, forKey: .quantity_shipped)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(unit, forKey: .unit)
    }

    public func toMap() -> [String: Any] {
        return [
            "name": name as Any,
            "order_item_id": order_item_id as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "quantity_cancelled": quantity_cancelled as Any,
            "quantity_open": quantity_open as Any,
            "quantity_shipped": quantity_shipped as Any,
            "sku": sku as Any,
            "unit": unit as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShippablePosition {
        return OrderShippablePosition(
            name: map["name"] as? String,
            order_item_id: map["order_item_id"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            quantity_cancelled: map["quantity_cancelled"] as? Double,
            quantity_open: map["quantity_open"] as? Double,
            quantity_shipped: map["quantity_shipped"] as? Double,
            sku: map["sku"] as? String,
            unit: map["unit"] as? String
        )
    }
}
