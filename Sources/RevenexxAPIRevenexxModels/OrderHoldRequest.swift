import Foundation
import JSONCodable

/// 
open class OrderHoldRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
    }

    /// Why the order is blocked (shown on the shipping guard).
    public let reason: String?

    init(
        reason: String?
    ) {
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderHoldRequest {
        return OrderHoldRequest(
            reason: map["reason"] as? String
        )
    }
}
