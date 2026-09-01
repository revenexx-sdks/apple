import Foundation
import JSONCodable

/// 
open class InventoryReleaseRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case order_ref = "order_ref"
    }

    /// The order this hold belongs to. The caller supplies it — this app mints nothing — and it is the handle POST /inventories/release and POST /inventories/commit act on, so it has to be the same string the order carries elsewhere. At least one character (CHECK `length(order_ref) > 0`). Not unique: an order holds one reservation per item, and they are released or committed together. Every ACTIVE hold under this reference is given back; ones already committed or released are left alone. A reference no reservation carries releases nothing and answers `released: 0` — not an error, which is what makes a retried cancellation safe.
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

    public static func from(map: [String: Any] ) -> InventoryReleaseRequest {
        return InventoryReleaseRequest(
            order_ref: map["order_ref"] as! String
        )
    }
}
