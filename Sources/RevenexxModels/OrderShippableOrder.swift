import Foundation
import JSONCodable
import RevenexxEnums

/// Just enough of the order to render the answer — the full row is GET /orders/{id}.
open class OrderShippableOrder: Codable {

    enum CodingKeys: String, CodingKey {
        case fulfillment_status = "fulfillment_status"
        case hold_reason = "hold_reason"
        case id = "id"
        case number = "number"
        case on_hold = "on_hold"
        case status = "status"
    }

    /// Whether the order has SHIPPED, and the one dimension nobody writes: it is DERIVED after every quantity change from the positions' own bookkeeping. 'fulfilled' means shipped >= ordered − cancelled across all positions, 'partial' means something went out. Sending it has no effect; ship, cancel or return something and it moves.
    public let fulfillment_status: RevenexxEnums.OrderFulfillmentStatus?
    /// Why the order is held, in the words the shipping guard quotes back. Null when it is not held — releasing a hold clears it.
    public let hold_reason: String?
    /// The order this answer is about.
    public let id: String?
    /// The order number a human quotes — drawn from the tenant's order range at place-time, unique per tenant and never reused. It is NOT the id: every route addresses an order by uuid, and GET /orders?number=… is how a number becomes one.
    public let number: String?
    /// A business stop, ORTHOGONAL to status: a held order keeps its lifecycle state and is refused at the guards. How far the hold reaches is the tenant's call (on_hold_blocks: shipping only, shipping and cancellation, or nothing at all).
    public let on_hold: Bool?
    /// Where the order stands in its LIFECYCLE, and one of three independent status dimensions. 'pending' = created but not placed, an order waiting for approval; 'placed' = accepted, nothing shipped; 'in_fulfillment' = part of it has gone out, or all of it has and the tenant does not close on shipment; 'completed' and 'cancelled' end it. Moved by the action routes only — it is not writable through PUT /orders/{id}.
    public let status: RevenexxEnums.OrderStatus?

    init(
        fulfillment_status: RevenexxEnums.OrderFulfillmentStatus?,
        hold_reason: String?,
        id: String?,
        number: String?,
        on_hold: Bool?,
        status: RevenexxEnums.OrderStatus?
    ) {
        self.fulfillment_status = fulfillment_status
        self.hold_reason = hold_reason
        self.id = id
        self.number = number
        self.on_hold = on_hold
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let fulfillment_statusString = try container.decodeIfPresent(String.self, forKey: .fulfillment_status) {
            self.fulfillment_status = RevenexxEnums.OrderFulfillmentStatus(rawValue: fulfillment_statusString)
        } else {
            self.fulfillment_status = nil
        }
        self.hold_reason = try container.decodeIfPresent(String.self, forKey: .hold_reason)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.on_hold = try container.decodeIfPresent(Bool.self, forKey: .on_hold)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.OrderStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(fulfillment_status?.rawValue, forKey: .fulfillment_status)
        try container.encodeIfPresent(hold_reason, forKey: .hold_reason)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(on_hold, forKey: .on_hold)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "fulfillment_status": fulfillment_status?.rawValue as Any,
            "hold_reason": hold_reason as Any,
            "id": id as Any,
            "number": number as Any,
            "on_hold": on_hold as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShippableOrder {
        return OrderShippableOrder(
            fulfillment_status: map["fulfillment_status"] as? String != nil ? OrderFulfillmentStatus(rawValue: map["fulfillment_status"] as! String) : nil,
            hold_reason: map["hold_reason"] as? String,
            id: map["id"] as? String,
            number: map["number"] as? String,
            on_hold: map["on_hold"] as? Bool,
            status: map["status"] as? String != nil ? OrderStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
