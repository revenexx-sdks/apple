import Foundation
import JSONCodable

/// 
open class InventoryCommitRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case order_ref = "order_ref"
    }

    /// The order this hold belongs to. The caller supplies it — this app mints nothing — and it is the handle POST /inventories/release and POST /inventories/commit act on, so it has to be the same string the order carries elsewhere. At least one character (CHECK `length(order_ref) > 0`). Not unique: an order holds one reservation per item, and they are released or committed together. Every ACTIVE hold under this reference ships: `on_hand` and `reserved` both fall and a `shipment` booking is written for each. Unlike release, committing an order that has nothing active is a 422 — it means the hold was already released or already shipped, and shipping twice is worth saying out loud.
    public let order_ref: String

    init(
        order_ref: String
    ) {
        self.order_ref = order_ref
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order_ref = try container.decode(String.self, forKey: .order_ref)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(order_ref, forKey: .order_ref)
    }

    public func toMap() -> [String: Any] {
        return [
            "order_ref": order_ref as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryCommitRequest {
        return InventoryCommitRequest(
            order_ref: map["order_ref"] as! String
        )
    }
}
