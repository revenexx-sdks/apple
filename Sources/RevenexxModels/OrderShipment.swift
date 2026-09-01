import Foundation
import JSONCodable

/// One handover to a carrier — a delivery note. An order has as many of these as it took to get the goods out; each carries the position quantities it booked.
open class OrderShipment: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case created_at = "created_at"
        case id = "id"
        case items = "items"
        case metadata = "metadata"
        case number = "number"
        case order_id = "order_id"
        case shipped_at = "shipped_at"
        case tracking_code = "tracking_code"
        case tracking_url = "tracking_url"
    }

    /// Who is carrying it, in the merchant's own words. Free text — this app neither validates it nor knows the carrier's API.
    public let carrier: String?
    /// When the shipment was booked here, which is not necessarily when it left — that is shipped_at.
    public let created_at: String?
    /// Primary key of the shipment.
    public let id: String?
    /// The booked position quantities of this shipment.
    public let items: [OrderShipmentItem]?
    /// Free-form data for the caller — the warehouse system's own reference for this handover. Stored and returned untouched.
    public let metadata: [String: AnyCodable]?
    /// The DELIVERY NOTE number — drawn from the tenant's delivery range, unique per tenant, and a different series from the order number. A caller may supply its own when the number is issued by the warehouse system instead.
    public let number: String?
    /// The order this shipment belongs to. Deleting the order deletes its shipments.
    public let order_id: String?
    /// When the goods actually left. Defaults to now, and a caller may backdate it — a shipment booked on Monday for a Friday handover says Friday.
    public let shipped_at: String?
    /// The consignment number the carrier issued. Free text: every carrier formats it differently and this app stores whatever it is given.
    public let tracking_code: String?
    /// Where a human can follow the parcel. Supplied by the caller — this app does not build it, because only the caller knows the carrier's tracking address.
    public let tracking_url: String?

    init(
        carrier: String?,
        created_at: String?,
        id: String?,
        items: [OrderShipmentItem]?,
        metadata: [String: AnyCodable]?,
        number: String?,
        order_id: String?,
        shipped_at: String?,
        tracking_code: String?,
        tracking_url: String?
    ) {
        self.carrier = carrier
        self.created_at = created_at
        self.id = id
        self.items = items
        self.metadata = metadata
        self.number = number
        self.order_id = order_id
        self.shipped_at = shipped_at
        self.tracking_code = tracking_code
        self.tracking_url = tracking_url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decodeIfPresent(String.self, forKey: .carrier)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.items = try container.decodeIfPresent([OrderShipmentItem].self, forKey: .items)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.shipped_at = try container.decodeIfPresent(String.self, forKey: .shipped_at)
        self.tracking_code = try container.decodeIfPresent(String.self, forKey: .tracking_code)
        self.tracking_url = try container.decodeIfPresent(String.self, forKey: .tracking_url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(carrier, forKey: .carrier)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(shipped_at, forKey: .shipped_at)
        try container.encodeIfPresent(tracking_code, forKey: .tracking_code)
        try container.encodeIfPresent(tracking_url, forKey: .tracking_url)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "items": items?.map { $0.toMap() } as Any,
            "metadata": metadata as Any,
            "number": number as Any,
            "order_id": order_id as Any,
            "shipped_at": shipped_at as Any,
            "tracking_code": tracking_code as Any,
            "tracking_url": tracking_url as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShipment {
        return OrderShipment(
            carrier: map["carrier"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            items: (map["items"] as? [[String: Any]] ?? []).map { OrderShipmentItem.from(map: $0) },
            metadata: map["metadata"] as? [String: AnyCodable],
            number: map["number"] as? String,
            order_id: map["order_id"] as? String,
            shipped_at: map["shipped_at"] as? String,
            tracking_code: map["tracking_code"] as? String,
            tracking_url: map["tracking_url"] as? String
        )
    }
}
