import Foundation
import JSONCodable

/// 
open class ChannelVisibilityRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case channel = "channel"
        case items = "items"
    }

    /// The channel `code` (the scope slug) to evaluate against, trimmed and lowercased before it is matched. Optional, and through api.revenexx.com it is the ONLY way to name a channel explicitly: the x-revenexx-channel header is not forwarded to the app, so without this the resolution falls through to the scope_context.channel claim and then to the tenant's default channel. A code no channel carries is not an error — the answer is resolved:false with reason 'unknown_channel', so a caller can tell it from an outage.
    public let channel: String?
    /// The rows to decide on, each with the channel assignments Baseline holds for it. POST /api/v1/scopes/lookup?dimension=channel answers in exactly this shape. At most 500 — Baseline's own lookup ceiling.
    public let items: [ChannelVisibilityItem]

    init(
        channel: String?,
        items: [ChannelVisibilityItem]
    ) {
        self.channel = channel
        self.items = items
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel = try container.decodeIfPresent(String.self, forKey: .channel)
        self.items = try container.decode([ChannelVisibilityItem].self, forKey: .items)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel, forKey: .channel)
        try container.encode(items, forKey: .items)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel": channel as Any,
            "items": items.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelVisibilityRequest {
        return ChannelVisibilityRequest(
            channel: map["channel"] as? String,
            items: (map["items"] as! [[String: Any]]).map { ChannelVisibilityItem.from(map: $0) }
        )
    }
}
