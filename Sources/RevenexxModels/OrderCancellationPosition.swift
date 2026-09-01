import Foundation
import JSONCodable

/// One position quantity this cancellation removed.
open class OrderCancellationPosition: Codable {

    enum CodingKeys: String, CodingKey {
        case order_item_id = "order_item_id"
        case quantity = "quantity"
    }

    /// The order item this quantity was booked against — an id out of the same order, never another one.
    public let order_item_id: String?
    /// The quantity booked on that position, in the position's own unit. Three decimal places, so 0.5 m of cable is a real booking.
    public let quantity: Double?

    init(
        order_item_id: String?,
        quantity: Double?
    ) {
        self.order_item_id = order_item_id
        self.quantity = quantity
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order_item_id = try container.decodeIfPresent(String.self, forKey: .order_item_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(order_item_id, forKey: .order_item_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
    }

    public func toMap() -> [String: Any] {
        return [
            "order_item_id": order_item_id as Any,
            "quantity": quantity as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCancellationPosition {
        return OrderCancellationPosition(
            order_item_id: map["order_item_id"] as? String,
            quantity: map["quantity"] as? Double
        )
    }
}
