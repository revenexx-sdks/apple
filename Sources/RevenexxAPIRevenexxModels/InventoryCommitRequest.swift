import Foundation
import JSONCodable

/// 
open class InventoryCommitRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case order_ref = "order_ref"
    }

    /// The order whose active reservations are committed (shipment).
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
