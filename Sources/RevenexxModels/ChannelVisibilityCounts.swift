import Foundation
import JSONCodable

/// The three tallies, so a caller can log or alert on a batch without walking it.
open class ChannelVisibilityCounts: Codable {

    enum CodingKeys: String, CodingKey {
        case hidden = "hidden"
        case total = "total"
        case visible = "visible"
    }

    /// How many must not be. A batch where this equals `total` and the reason is no_channel_context means the channel did not resolve, not that the assortment is empty.
    public let hidden: Int?
    /// How many rows were decided — the length of the `items` sent.
    public let total: Int?
    /// How many may be shown.
    public let visible: Int?

    init(
        hidden: Int?,
        total: Int?,
        visible: Int?
    ) {
        self.hidden = hidden
        self.total = total
        self.visible = visible
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.hidden = try container.decodeIfPresent(Int.self, forKey: .hidden)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.visible = try container.decodeIfPresent(Int.self, forKey: .visible)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(hidden, forKey: .hidden)
        try container.encodeIfPresent(total, forKey: .total)
        try container.encodeIfPresent(visible, forKey: .visible)
    }

    public func toMap() -> [String: Any] {
        return [
            "hidden": hidden as Any,
            "total": total as Any,
            "visible": visible as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelVisibilityCounts {
        return ChannelVisibilityCounts(
            hidden: map["hidden"] as? Int,
            total: map["total"] as? Int,
            visible: map["visible"] as? Int
        )
    }
}
