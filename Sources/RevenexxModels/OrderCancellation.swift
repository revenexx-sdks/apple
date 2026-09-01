import Foundation
import JSONCodable
import RevenexxEnums

/// A record of what was taken off an order and why — either the whole order (while nothing had shipped) or named quantities off a partly shipped one.
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

    /// Who cancelled, as the caller reported it — an operator, a desk, a system. Free text; this app does not resolve it against a user directory.
    public let cancelled_by: String?
    /// When the cancellation was recorded.
    public let created_at: String?
    /// Primary key of the cancellation record.
    public let id: String?
    /// The order that was cancelled from.
    public let order_id: String?
    /// What this record removed. A scope 'order' record carries every position in full; a scope 'items' record carries exactly the quantities that were named.
    public let positions: [OrderCancellationPosition]?
    /// Why it was cancelled, free text. Mandatory when the tenant sets cancel_requires_reason — for those merchants an unexplained cancellation is refused with a 400.
    public let reason: String?
    /// Which of the two cancellations this was: 'order' is the full cancel (only possible while nothing has shipped, and it cancels every position in full), 'items' is the quantity-based one that takes open quantities off a partly shipped order.
    public let scope: RevenexxEnums.OrderCancellationScope?

    init(
        cancelled_by: String?,
        created_at: String?,
        id: String?,
        order_id: String?,
        positions: [OrderCancellationPosition]?,
        reason: String?,
        scope: RevenexxEnums.OrderCancellationScope?
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
        self.positions = try container.decodeIfPresent([OrderCancellationPosition].self, forKey: .positions)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        if let scopeString = try container.decodeIfPresent(String.self, forKey: .scope) {
            self.scope = RevenexxEnums.OrderCancellationScope(rawValue: scopeString)
        } else {
            self.scope = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cancelled_by, forKey: .cancelled_by)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(scope?.rawValue, forKey: .scope)
    }

    public func toMap() -> [String: Any] {
        return [
            "cancelled_by": cancelled_by as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "order_id": order_id as Any,
            "positions": positions?.map { $0.toMap() } as Any,
            "reason": reason as Any,
            "scope": scope?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCancellation {
        return OrderCancellation(
            cancelled_by: map["cancelled_by"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            order_id: map["order_id"] as? String,
            positions: (map["positions"] as? [[String: Any]] ?? []).map { OrderCancellationPosition.from(map: $0) },
            reason: map["reason"] as? String,
            scope: map["scope"] as? String != nil ? OrderCancellationScope(rawValue: map["scope"] as! String) : nil
        )
    }
}
