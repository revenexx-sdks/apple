import Foundation
import JSONCodable

/// 
open class OrderCancelRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case cancelled_by = "cancelled_by"
        case reason = "reason"
    }

    /// Acting user/system.
    public let cancelled_by: String?
    /// 
    public let reason: String?

    init(
        cancelled_by: String?,
        reason: String?
    ) {
        self.cancelled_by = cancelled_by
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cancelled_by = try container.decodeIfPresent(String.self, forKey: .cancelled_by)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cancelled_by, forKey: .cancelled_by)
        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "cancelled_by": cancelled_by as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCancelRequest {
        return OrderCancelRequest(
            cancelled_by: map["cancelled_by"] as? String,
            reason: map["reason"] as? String
        )
    }
}
