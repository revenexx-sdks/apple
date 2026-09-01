import Foundation
import JSONCodable

/// Correct ONE stock row. The row already knows its location and its item, so a caller owes only the signed delta and a reason — which is exactly what an operator can be asked for in a dialog.
open class StockLevelAdjustRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case reason = "reason"
    }

    /// The SIGNED correction to this row's `on_hand`: −3 writes off three, +3 finds three. A delta, not the new balance. Zero is refused (400). A correction that would take `on_hand` below zero is a 422 the database insists on; one that would take it below this row's own `reserved` is a 422 the `allow_negative_stock` setting can permit.
    public let quantity: Double
    /// Why this row is being corrected, written onto the ledger booking. Owed unless `movement_reason_required` is 'none'.
    public let reason: String?

    init(
        quantity: Double,
        reason: String?
    ) {
        self.quantity = quantity
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.quantity = try container.decode(Double.self, forKey: .quantity)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(quantity, forKey: .quantity)
        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "quantity": quantity as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> StockLevelAdjustRequest {
        return StockLevelAdjustRequest(
            quantity: map["quantity"] as! Double,
            reason: map["reason"] as? String
        )
    }
}
