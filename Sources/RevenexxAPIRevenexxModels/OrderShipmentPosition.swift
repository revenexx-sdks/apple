import Foundation
import JSONCodable

/// A position quantity to ship — guarded against the open quantity.
open class OrderShipmentPosition: Codable {

    enum CodingKeys: String, CodingKey {
        case order_item_id = "order_item_id"
        case quantity = "quantity"
    }

    /// The order item (position) to act on.
    public let order_item_id: String
    /// Defaults to the full remaining quantity of the position.
    public let quantity: Double?

    init(
        order_item_id: String,
        quantity: Double?
    ) {
        self.order_item_id = order_item_id
        self.quantity = quantity
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order_item_id = try container.decode(String.self, forKey: .order_item_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(order_item_id, forKey: .order_item_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
    }

    public func toMap() -> [String: Any] {
        return [
            "order_item_id": order_item_id as Any,
            "quantity": quantity as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShipmentPosition {
        return OrderShipmentPosition(
            order_item_id: map["order_item_id"] as! String,
            quantity: map["quantity"] as? Double
        )
    }
}
