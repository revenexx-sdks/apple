import Foundation
import JSONCodable

/// One line of a delivery note: how much of one order position went out in one shipment.
open class OrderShipmentItem: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case order_item_id = "order_item_id"
        case quantity = "quantity"
        case shipment_id = "shipment_id"
    }

    /// When the booking was written.
    public let created_at: String?
    /// Primary key of the booked position line.
    public let id: String?
    /// Which order position went out. Always a position of the same order as the shipment.
    public let order_item_id: String?
    /// How much of that position this shipment carried. The sum of these over all shipments is the position's quantity_shipped.
    public let quantity: Double?
    /// The shipment this booking belongs to. Deleting the shipment deletes it.
    public let shipment_id: String?

    init(
        created_at: String?,
        id: String?,
        order_item_id: String?,
        quantity: Double?,
        shipment_id: String?
    ) {
        self.created_at = created_at
        self.id = id
        self.order_item_id = order_item_id
        self.quantity = quantity
        self.shipment_id = shipment_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.order_item_id = try container.decodeIfPresent(String.self, forKey: .order_item_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.shipment_id = try container.decodeIfPresent(String.self, forKey: .shipment_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(order_item_id, forKey: .order_item_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(shipment_id, forKey: .shipment_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "order_item_id": order_item_id as Any,
            "quantity": quantity as Any,
            "shipment_id": shipment_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShipmentItem {
        return OrderShipmentItem(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            order_item_id: map["order_item_id"] as? String,
            quantity: map["quantity"] as? Double,
            shipment_id: map["shipment_id"] as? String
        )
    }
}
