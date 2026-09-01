import Foundation
import JSONCodable

/// One position quantity registered for return.
open class OrderReturnedPosition: Codable {

    enum CodingKeys: String, CodingKey {
        case order_item_id = "order_item_id"
        case quantity = "quantity"
        case restock = "restock"
    }

    /// The order item this quantity was booked against — an id out of the same order, never another one.
    public let order_item_id: String?
    /// The quantity booked on that position, in the position's own unit. Three decimal places, so 0.5 m of cable is a real booking.
    public let quantity: Double?
    /// Whether this quantity is reported for restocking when the return completes. Restocking itself stays an explicit inventories.restock call by the orchestrator — this app never writes another app's stock.
    public let restock: Bool?

    init(
        order_item_id: String?,
        quantity: Double?,
        restock: Bool?
    ) {
        self.order_item_id = order_item_id
        self.quantity = quantity
        self.restock = restock
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order_item_id = try container.decodeIfPresent(String.self, forKey: .order_item_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.restock = try container.decodeIfPresent(Bool.self, forKey: .restock)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(order_item_id, forKey: .order_item_id)
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

    public static func from(map: [String: Any] ) -> OrderReturnedPosition {
        return OrderReturnedPosition(
            order_item_id: map["order_item_id"] as? String,
            quantity: map["quantity"] as? Double,
            restock: map["restock"] as? Bool
        )
    }
}
