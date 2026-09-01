import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelTypeCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case description = "description"
        case descriptions = "descriptions"
        case is_default = "is_default"
        case labels = "labels"
        case position = "position"
        case title = "title"
        case tone = "tone"
    }

    /// What `channels.type` will store. Lowercased and trimmed before it is written, and fixed from then on — a rename would orphan every channel carrying it.
    public let code: String
    /// One sentence on what kind of place this type of channel is, for the merchant choosing between them. Plain text, in the tenant's primary language; `descriptions` carries the per-locale ones.
    public let description: String?
    /// A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let descriptions: [String: AnyCodable]?
    /// Promote this type; the previous default is demoted. The default is the type a channel created without one gets.
    public let is_default: Bool?
    /// A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let labels: [String: AnyCodable]?
    /// Sort position (default 0). GET /channels/types answers in this order; ties fall back to the code.
    public let position: Int?
    /// The fallback name. `labels` carries the per-locale ones.
    public let title: String
    /// Badge colour (default 'neutral'). A value outside the palette is ignored rather than refused.
    public let tone: RevenexxEnums.ChannelTypeTone?

    init(
        code: String,
        description: String?,
        descriptions: [String: AnyCodable]?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        position: Int?,
        title: String,
        tone: RevenexxEnums.ChannelTypeTone?
    ) {
        self.code = code
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

        self.code = try container.decode(String.self, forKey: .code)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.title = try container.decode(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.ChannelTypeTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptions, forKey: .descriptions)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "description": description as Any,
            "descriptions": descriptions as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "position": position as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelTypeCreateRequest {
        return ChannelTypeCreateRequest(
            code: map["code"] as! String,
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            title: map["title"] as! String,
            tone: map["tone"] as? String != nil ? ChannelTypeTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
