import Foundation
import JSONCodable

/// 
open class OrderCancellation: Codable {

    enum CodingKeys: String, CodingKey {
        case cancelled_by = "cancelled_by"
        case created_at = "created_at"
        case id = "id"
        case order_id = "order_id"
        case positions = "positions"
        case reason = "reason"
        case scope = "scope"
    }

    /// 
    public let cancelled_by: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let order_id: String?
    /// 
    public let positions: [String: AnyCodable]?
    /// 
    public let reason: String?
    /// 
    public let scope: String?

    init(
        cancelled_by: String?,
        created_at: String?,
        id: String?,
        order_id: String?,
        positions: [String: AnyCodable]?,
        reason: String?,
        scope: String?
    ) {
        self.cancelled_by = cancelled_by
        self.created_at = created_at
        self.id = id
        self.order_id = order_id
        self.positions = positions
        self.reason = reason
        self.scope = scope
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cancelled_by = try container.decodeIfPresent(String.self, forKey: .cancelled_by)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.positions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .positions)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.scope = try container.decodeIfPresent(String.self, forKey: .scope)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cancelled_by, forKey: .cancelled_by)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(scope, forKey: .scope)
    }

    public func toMap() -> [String: Any] {
        return [
            "cancelled_by": cancelled_by as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "order_id": order_id as Any,
            "positions": positions as Any,
            "reason": reason as Any,
            "scope": scope as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCancellation {
        return OrderCancellation(
            cancelled_by: map["cancelled_by"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            order_id: map["order_id"] as? String,
            positions: map["positions"] as? [String: AnyCodable],
            reason: map["reason"] as? String,
            scope: map["scope"] as? String
        )
    }
}
