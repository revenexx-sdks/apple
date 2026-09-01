import Foundation
import JSONCodable

/// One entry of the audit trail, which is also the domain event feed: every action writes a row, the manifest emits order_event.created on insert, and the row name IS the event name on the bus.
open class OrderEvent: Codable {

    enum CodingKeys: String, CodingKey {
        case actor = "actor"
        case created_at = "created_at"
        case id = "id"
        case name = "name"
        case order_id = "order_id"
        case payload = "payload"
    }

    /// Who caused it: the resolved contact id of the acting principal. Only order.placed and order.requested carry one today — every other row is null — so filtering on it filters to those two names. The database constrains nothing here (the column is text); the uuid shape is what this app WRITES, which is also why no example is published: no id an app invents names a row a tenant holds.
    public let actor: String?
    /// When it happened. The trail comes back oldest first, which is the order a human reads a history in.
    public let created_at: String?
    /// Primary key of the event row.
    public let id: String?
    /// WHAT happened, and this is the domain event: the manifest emits order_event.created on insert and this value is the event name on the bus. The names this app writes are order.placed, order.requested, order.updated, order.acknowledged, order.cancelled, order.item.cancelled, order.shipment.created, order.completed, order.held, order.unheld, order.payment_status.changed, order.comment.added, order.return.registered, order.return.received, order.return.completed and order.return.rejected.
    public let name: String?
    /// The order this happened to.
    public let order_id: String?
    /// The machine-readable body, and its shape follows `name`. order.placed / order.requested carry number, grand_total, currency, item_count, cart_id — plus approval_reason (permission | value_threshold) and threshold when the order is waiting for sign-off. order.shipment.created carries shipment_id, number, carrier, tracking_code and the booked positions. order.item.cancelled and order.return.* carry positions and the reason or resolution. order.completed carries via (shipment | payment | manual). order.payment_status.changed carries from, to and payment_id. Nothing validates it: it is what the route that wrote the row put there.
    public let payload: [String: AnyCodable]?

    init(
        actor: String?,
        created_at: String?,
        id: String?,
        name: String?,
        order_id: String?,
        payload: [String: AnyCodable]?
    ) {
        self.actor = actor
        self.created_at = created_at
        self.id = id
        self.name = name
        self.order_id = order_id
        self.payload = payload
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.actor = try container.decodeIfPresent(String.self, forKey: .actor)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.payload = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payload)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(actor, forKey: .actor)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(payload, forKey: .payload)
    }

    public func toMap() -> [String: Any] {
        return [
            "actor": actor as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "name": name as Any,
            "order_id": order_id as Any,
            "payload": payload as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderEvent {
        return OrderEvent(
            actor: map["actor"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            name: map["name"] as? String,
            order_id: map["order_id"] as? String,
            payload: map["payload"] as? [String: AnyCodable]
        )
    }
}
