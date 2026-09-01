import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelVisibilityDecision: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case reason = "reason"
        case visible = "visible"
    }

    /// The id as it was sent, verbatim.
    public let id: String?
    /// Why the row was shown or hidden — the answer is auditable, not a bare boolean.
    public let reason: RevenexxEnums.ChannelVisibilityReason?
    /// Whether this row may be shown in the resolved channel. The same answer as membership in `visible`; `reason` says why.
    public let visible: Bool?

    init(
        id: String?,
        reason: RevenexxEnums.ChannelVisibilityReason?,
        visible: Bool?
    ) {
        self.id = id
        self.reason = reason
        self.visible = visible
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        if let reasonString = try container.decodeIfPresent(String.self, forKey: .reason) {
            self.reason = RevenexxEnums.ChannelVisibilityReason(rawValue: reasonString)
        } else {
            self.reason = nil
        }
        self.visible = try container.decodeIfPresent(Bool.self, forKey: .visible)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(reason?.rawValue, forKey: .reason)
        try container.encodeIfPresent(visible, forKey: .visible)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "reason": reason?.rawValue as Any,
            "visible": visible as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelVisibilityDecision {
        return ChannelVisibilityDecision(
            id: map["id"] as? String,
            reason: map["reason"] as? String != nil ? ChannelVisibilityReason(rawValue: map["reason"] as! String) : nil,
            visible: map["visible"] as? Bool
        )
    }
}
