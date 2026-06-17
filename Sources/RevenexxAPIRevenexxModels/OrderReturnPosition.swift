import Foundation
import JSONCodable

/// A position quantity to return — guarded against the shipped (not yet returned) quantity.
open class OrderReturnPosition: Codable {

    enum CodingKeys: String, CodingKey {
        case order_item_id = "order_item_id"
        case quantity = "quantity"
        case restock = "restock"
    }

    /// The order item (position) to act on.
    public let order_item_id: String
    /// Defaults to the full remaining quantity of the position.
    public let quantity: Double?
    /// Report this position for restocking when the return completes (the explicit inventories.restock call stays with the orchestrator).
    public let restock: Bool?

    init(
        order_item_id: String,
        quantity: Double?,
        restock: Bool?
    ) {
        self.order_item_id = order_item_id
        self.quantity = quantity
        self.restock = restock
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order_item_id = try container.decode(String.self, forKey: .order_item_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.restock = try container.decodeIfPresent(Bool.self, forKey: .restock)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(order_item_id, forKey: .order_item_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(restock, forKey: .restock)
    }

    public func toMap() -> [String: Any] {
        return [
            "order_item_id": order_item_id as Any,
            "quantity": quantity as Any,
            "restock": restock as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturnPosition {
        return OrderReturnPosition(
            order_item_id: map["order_item_id"] as! String,
            quantity: map["quantity"] as? Double,
            restock: map["restock"] as? Bool
        )
    }
}
