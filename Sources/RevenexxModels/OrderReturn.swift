import Foundation
import JSONCodable
import RevenexxEnums

/// Goods coming BACK, with their own lifecycle: registered → received → completed | rejected. Only completing books anything onto the positions; registering and receiving are announcements.
open class OrderReturn: Codable {

    enum CodingKeys: String, CodingKey {
        case completed_at = "completed_at"
        case created_at = "created_at"
        case id = "id"
        case metadata = "metadata"
        case number = "number"
        case order_id = "order_id"
        case positions = "positions"
        case reason = "reason"
        case received_at = "received_at"
        case registered_at = "registered_at"
        case rejected_at = "rejected_at"
        case resolution = "resolution"
        case status = "status"
        case updated_at = "updated_at"
    }

    /// When the return was settled, stamped by the SERVER. Never taken from the body: a client clock records when a client thinks it acted, not when the goods were booked.
    public let completed_at: String?
    /// When the return row was written.
    public let created_at: String?
    /// Primary key of the return. The {rid} segment of the return routes.
    public let id: String?
    /// Free-form data for the caller — the returns portal's own reference. Stored and returned untouched.
    public let metadata: [String: AnyCodable]?
    /// The RETURN number — drawn from the tenant's return range, unique per tenant, and a third series alongside orders and delivery notes. What the customer writes on the parcel.
    public let number: String?
    /// The order the goods are coming back from. A return of another order is a 404 on these routes, not a cross-order write.
    public let order_id: String?
    /// The positions and quantities this return covers, fixed when it was registered and guarded against the shipped-but-not-yet-returned quantity of each. Entries flagged restock are what the completion reports back for the inventories call.
    public let positions: [OrderReturnedPosition]?
    /// Why the goods are coming back, free text as the customer or the desk stated it. Also what /reject stores when it is given no resolution out of the published set.
    public let reason: String?
    /// When the goods physically arrived back. Null until POST …/receive — and null forever on a return that was completed straight out of registered, which is allowed.
    public let received_at: String?
    /// When the return was announced. Defaults to now.
    public let registered_at: String?
    /// When the return was refused. Null unless it was.
    public let rejected_at: String?
    /// How it ended, in one of the words this app publishes — the settlement words on a completion (refund, partial_refund, replacement, repair, store_credit), the refusal words on a rejection (wear_and_tear, not_returnable); GET /orders/vocabularies/return-resolutions carries both sets with the stage that accepts each. The column carries no database constraint; the ROUTES enforce the set, which is what stopped a client settling returns with a word nobody else knew. On a rejection that named no resolution, the free-text reason is stored here instead — which is the one case a value outside the two sets appears.
    public let resolution: String?
    /// Where the return stands: 'registered' = announced, nothing booked; 'received' = the goods are back but not yet settled; 'completed' = settled, and the only transition that books quantity_returned; 'rejected' = refused, nothing booked. The last two are final.
    public let status: RevenexxEnums.OrderReturnStatus?
    /// When the return last changed — each of its transitions writes it.
    public let updated_at: String?

    init(
        completed_at: String?,
        created_at: String?,
        id: String?,
        metadata: [String: AnyCodable]?,
        number: String?,
        order_id: String?,
        positions: [OrderReturnedPosition]?,
        reason: String?,
        received_at: String?,
        registered_at: String?,
        rejected_at: String?,
        resolution: String?,
        status: RevenexxEnums.OrderReturnStatus?,
        updated_at: String?
    ) {
        self.completed_at = completed_at
        self.created_at = created_at
        self.id = id
        self.metadata = metadata
        self.number = number
        self.order_id = order_id
        self.positions = positions
        self.reason = reason
        self.received_at = received_at
        self.registered_at = registered_at
        self.rejected_at = rejected_at
        self.resolution = resolution
        self.status = status
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.completed_at = try container.decodeIfPresent(String.self, forKey: .completed_at)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.positions = try container.decodeIfPresent([OrderReturnedPosition].self, forKey: .positions)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.received_at = try container.decodeIfPresent(String.self, forKey: .received_at)
        self.registered_at = try container.decodeIfPresent(String.self, forKey: .registered_at)
        self.rejected_at = try container.decodeIfPresent(String.self, forKey: .rejected_at)
        self.resolution = try container.decodeIfPresent(String.self, forKey: .resolution)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.OrderReturnStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(completed_at, forKey: .completed_at)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(received_at, forKey: .received_at)
        try container.encodeIfPresent(registered_at, forKey: .registered_at)
        try container.encodeIfPresent(rejected_at, forKey: .rejected_at)
        try container.encodeIfPresent(resolution, forKey: .resolution)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "completed_at": completed_at as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "metadata": metadata as Any,
            "number": number as Any,
            "order_id": order_id as Any,
            "positions": positions?.map { $0.toMap() } as Any,
            "reason": reason as Any,
            "received_at": received_at as Any,
            "registered_at": registered_at as Any,
            "rejected_at": rejected_at as Any,
            "resolution": resolution as Any,
            "status": status?.rawValue as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturn {
        return OrderReturn(
            completed_at: map["completed_at"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            number: map["number"] as? String,
            order_id: map["order_id"] as? String,
            positions: (map["positions"] as? [[String: Any]] ?? []).map { OrderReturnedPosition.from(map: $0) },
            reason: map["reason"] as? String,
            received_at: map["received_at"] as? String,
            registered_at: map["registered_at"] as? String,
            rejected_at: map["rejected_at"] as? String,
            resolution: map["resolution"] as? String,
            status: map["status"] as? String != nil ? OrderReturnStatus(rawValue: map["status"] as! String) : nil,
            updated_at: map["updated_at"] as? String
        )
    }
}
