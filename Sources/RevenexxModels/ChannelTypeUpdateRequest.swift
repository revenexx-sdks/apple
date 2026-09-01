import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelTypeUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case descriptions = "descriptions"
        case is_default = "is_default"
        case labels = "labels"
        case position = "position"
        case title = "title"
        case tone = "tone"
    }

    /// Replace the one-sentence description. Sent as null it is cleared; omitted it is kept. `descriptions` carries the per-locale ones.
    public let description: String?
    /// A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let descriptions: [String: AnyCodable]?
    /// Promote this type; the previous default is demoted. Only `true` does anything — sending false does not demote this type, because some type must hold the flag.
    public let is_default: Bool?
    /// A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let labels: [String: AnyCodable]?
    /// Move the type in the order GET /channels/types answers in.
    public let position: Int?
    /// Rename the type. A blank or non-string title is ignored, not refused — the stored one is kept.
    public let title: String?
    /// Change the badge colour. A value outside the palette is ignored rather than refused, and the stored tone is kept.
    public let tone: RevenexxEnums.ChannelTypeTone?

    init(
        description: String?,
        descriptions: [String: AnyCodable]?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        title: String?,
        tone: RevenexxEnums.ChannelTypeTone?
    ) {
        self.description = description
        self.descriptions = descriptions
        self.is_default = is_default
        self.labels = labels
        self.position = position
        self.title = title
        self.tone = tone
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.ChannelTypeTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptions, forKey: .descriptions)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "descriptions": descriptions as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "position": position as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelTypeUpdateRequest {
        return ChannelTypeUpdateRequest(
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            title: map["title"] as? String,
            tone: map["tone"] as? String != nil ? ChannelTypeTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
