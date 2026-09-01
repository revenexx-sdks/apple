import Foundation
import JSONCodable

/// Stop the order. The reason is optional but is what the guard quotes back at whoever tries to ship, so an unexplained hold is a hold nobody can resolve.
open class OrderHoldRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
    }

    /// Why the order is held, in the words the shipping guard quotes back. Null when it is not held — releasing a hold clears it.
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
