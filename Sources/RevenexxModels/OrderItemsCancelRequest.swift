import Foundation
import JSONCodable

/// 
open class OrderItemsCancelRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case cancelled_by = "cancelled_by"
        case positions = "positions"
        case reason = "reason"
    }

    /// Who cancelled, as the caller reported it — an operator, a desk, a system. Free text; this app does not resolve it against a user directory.
    public let cancelled_by: String?
    /// The quantities to take off the order. Required here, unlike on /ship and /return: cancelling everything by default is not a thing anybody should be able to do by omission — that is what /cancel is for.
    public let positions: [OrderCancelPosition]
    /// Why it was cancelled, free text. Mandatory when the tenant sets cancel_requires_reason — for those merchants an unexplained cancellation is refused with a 400.
    public let reason: String?

    init(
        cancelled_by: String?,
        positions: [OrderCancelPosition],
        reason: String?
    ) {
        self.cancelled_by = cancelled_by
        self.positions = positions
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cancelled_by = try container.decodeIfPresent(String.self, forKey: .cancelled_by)
        self.positions = try container.decode([OrderCancelPosition].self, forKey: .positions)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cancelled_by, forKey: .cancelled_by)
        try container.encode(positions, forKey: .positions)
        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "cancelled_by": cancelled_by as Any,
            "positions": positions.map { $0.toMap() } as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderItemsCancelRequest {
        return OrderItemsCancelRequest(
            cancelled_by: map["cancelled_by"] as? String,
            positions: (map["positions"] as! [[String: Any]]).map { OrderCancelPosition.from(map: $0) },
            reason: map["reason"] as? String
        )
    }
}
