import Foundation
import JSONCodable

/// 
open class OrderItemsCancelRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case cancelled_by = "cancelled_by"
        case positions = "positions"
        case reason = "reason"
    }

    /// Acting user/system.
    public let cancelled_by: String?
    /// 
    public let positions: [OrderCancelPosition]
    /// 
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
