import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderReturnRejectRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
        case resolution = "resolution"
    }

    /// Free-text fallback for 'resolution' — a sentence about this one return, not a value out of the set.
    public let reason: String?
    /// Why the return was refused.
    public let resolution: RevenexxEnums.OrderReturnRefusal?

    init(
        reason: String?,
        resolution: RevenexxEnums.OrderReturnRefusal?
    ) {
        self.reason = reason
        self.resolution = resolution
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        if let resolutionString = try container.decodeIfPresent(String.self, forKey: .resolution) {
            self.resolution = RevenexxEnums.OrderReturnRefusal(rawValue: resolutionString)
        } else {
            self.resolution = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(resolution?.rawValue, forKey: .resolution)
    }

    public func toMap() -> [String: Any] {
        return [
            "reason": reason as Any,
            "resolution": resolution?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturnRejectRequest {
        return OrderReturnRejectRequest(
            reason: map["reason"] as? String,
            resolution: map["resolution"] as? String != nil ? OrderReturnRefusal(rawValue: map["resolution"] as! String) : nil
        )
    }
}
