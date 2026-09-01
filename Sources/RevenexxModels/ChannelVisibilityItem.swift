import Foundation
import JSONCodable

/// 
open class ChannelVisibilityItem: Codable {

    enum CodingKeys: String, CodingKey {
        case channels = "channels"
        case id = "id"
    }

    /// The row's channel scope slugs. Empty or absent means unassigned — the case the policy decides.
    public let channels: [String]?
    /// The row id, echoed back on the decision. Opaque to this app — it is never looked up, so any non-empty string is accepted and nothing has to exist. In practice it is the entity id POST /api/v1/scopes/lookup answered with, which is what the example shows.
    public let id: String

    init(
        channels: [String]?,
        id: String
    ) {
        self.channels = channels
        self.id = id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channels = try container.decodeIfPresent([String].self, forKey: .channels)
        self.id = try container.decode(String.self, forKey: .id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channels, forKey: .channels)
        try container.encode(id, forKey: .id)
    }

    public func toMap() -> [String: Any] {
        return [
            "channels": channels as Any,
            "id": id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelVisibilityItem {
        return ChannelVisibilityItem(
            channels: map["channels"] as? [String],
            id: map["id"] as! String
        )
    }
}
