import Foundation
import JSONCodable

/// 
open class OrderReturnRejectRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
        case resolution = "resolution"
    }

    /// Fallback for &#039;resolution&#039;.
    public let reason: String?
    /// Why the return was rejected.
    public let resolution: String?

    init(
        reason: String?,
        resolution: String?
    ) {
        self.reason = reason
        self.resolution = resolution
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.resolution = try container.decodeIfPresent(String.self, forKey: .resolution)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(resolution, forKey: .resolution)
    }

    public func toMap() -> [String: Any] {
        return [
            "reason": reason as Any,
            "resolution": resolution as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturnRejectRequest {
        return OrderReturnRejectRequest(
            reason: map["reason"] as? String,
            resolution: map["resolution"] as? String
        )
    }
}
