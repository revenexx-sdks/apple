import Foundation
import JSONCodable

/// What the booking produced: the new shipment with the quantities it took, and the order as it now stands.
open class OrderShipmentCreated: Codable {

    enum CodingKeys: String, CodingKey {
        case order = "order"
        case shipment = "shipment"
    }

    /// The order after the booking: fulfillment_status is re-derived from the positions, and status may have moved to in_fulfillment or (depending on the tenant's auto_complete_on) completed.
    public let order: Order?
    /// The shipment that was created, WITH the position quantities it booked — the only place a caller learns which quantities actually went out when the positions were defaulted.
    public let shipment: OrderShipment?

    init(
        order: Order?,
        shipment: OrderShipment?
    ) {
        self.order = order
        self.shipment = shipment
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order = try container.decodeIfPresent(Order.self, forKey: .order)
        self.shipment = try container.decodeIfPresent(OrderShipment.self, forKey: .shipment)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(order, forKey: .order)
        try container.encodeIfPresent(shipment, forKey: .shipment)
    }

    public func toMap() -> [String: Any] {
        return [
            "order": order?.toMap() as Any,
            "shipment": shipment?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShipmentCreated {
        return OrderShipmentCreated(
            order: Order.from(map: map["order"] as! [String: Any]),
            shipment: OrderShipment.from(map: map["shipment"] as! [String: Any])
        )
    }
}
