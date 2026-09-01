import Foundation
import JSONCodable

/// What a shipment of this order may still contain, and whether one would be accepted at all — answered by the same code POST /orders/{id}/ship runs, so the two cannot drift.
open class OrderShippable: Codable {

    enum CodingKeys: String, CodingKey {
        case blocked_reason = "blocked_reason"
        case open_positions = "open_positions"
        case open_quantity = "open_quantity"
        case order = "order"
        case positions = "positions"
        case shippable = "shippable"
    }

    /// Why not, in the very words POST /orders/{id}/ship would refuse with — including the hold reason where there is one. Null when `shippable` is true.
    public let blocked_reason: String?
    /// How many positions still have an open quantity — the number of lines a shipment dialog would offer.
    public let open_positions: Int?
    /// The summed open quantity over those positions. Mixes units where the order does, so it is a headline figure, not a total to act on.
    public let open_quantity: Double?
    /// Just enough of the order to render the answer — the full row is GET /orders/{id}.
    public let order: OrderShippableOrder?
    /// Every position of the order, in position order, each with its open quantity.
    public let positions: [OrderShippablePosition]?
    /// Whether a shipment would be accepted RIGHT NOW — the one question a "create shipment" button should be enabled on. False when the order is held, cancelled, completed, or has nothing open.
    public let shippable: Bool?

    init(
        blocked_reason: String?,
        open_positions: Int?,
        open_quantity: Double?,
        order: OrderShippableOrder?,
        positions: [OrderShippablePosition]?,
        shippable: Bool?
    ) {
        self.blocked_reason = blocked_reason
        self.open_positions = open_positions
        self.open_quantity = open_quantity
        self.order = order
        self.positions = positions
        self.shippable = shippable
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.blocked_reason = try container.decodeIfPresent(String.self, forKey: .blocked_reason)
        self.open_positions = try container.decodeIfPresent(Int.self, forKey: .open_positions)
        self.open_quantity = try container.decodeIfPresent(Double.self, forKey: .open_quantity)
        self.order = try container.decodeIfPresent(OrderShippableOrder.self, forKey: .order)
        self.positions = try container.decodeIfPresent([OrderShippablePosition].self, forKey: .positions)
        self.shippable = try container.decodeIfPresent(Bool.self, forKey: .shippable)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(blocked_reason, forKey: .blocked_reason)
        try container.encodeIfPresent(open_positions, forKey: .open_positions)
        try container.encodeIfPresent(open_quantity, forKey: .open_quantity)
        try container.encodeIfPresent(order, forKey: .order)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(shippable, forKey: .shippable)
    }

    public func toMap() -> [String: Any] {
        return [
            "blocked_reason": blocked_reason as Any,
            "open_positions": open_positions as Any,
            "open_quantity": open_quantity as Any,
            "order": order?.toMap() as Any,
            "positions": positions?.map { $0.toMap() } as Any,
            "shippable": shippable as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShippable {
        return OrderShippable(
            blocked_reason: map["blocked_reason"] as? String,
            open_positions: map["open_positions"] as? Int,
            open_quantity: map["open_quantity"] as? Double,
            order: OrderShippableOrder.from(map: map["order"] as! [String: Any]),
            positions: (map["positions"] as? [[String: Any]] ?? []).map { OrderShippablePosition.from(map: $0) },
            shippable: map["shippable"] as? Bool
        )
    }
}
