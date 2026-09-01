import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelVocabularyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case descriptions = "descriptions"
        case `final` = "final"
        case is_default = "is_default"
        case is_system = "is_system"
        case key = "key"
        case labels = "labels"
        case title = "title"
        case tone = "tone"
    }

    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// Table-backed vocabularies only: the localized descriptions. A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let descriptions: [String: AnyCodable]?
    /// The value ends the lifecycle.
    public let `final`: Bool?
    /// Table-backed vocabularies only: the value a create falls back to.
    public let is_default: Bool?
    /// Table-backed vocabularies only: seeded on install rather than added by the tenant. Still renameable and retirable.
    public let is_system: Bool?
    /// The value as the database stores and enforces it.
    public let key: String?
    /// Table-backed vocabularies only: the localized titles. `title` stays the fallback. A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let labels: [String: AnyCodable]?
    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Semantic badge colour. The client owns what each tone looks like.
    public let tone: RevenexxEnums.ChannelVocabularyTone?

    init(
        description: [String: AnyCodable]?,
        descriptions: [String: AnyCodable]?,
        `final`: Bool?,
        is_default: Bool?,
        is_system: Bool?,
        key: String?,
        labels: [String: AnyCodable]?,
        title: [String: AnyCodable]?,
        tone: RevenexxEnums.ChannelVocabularyTone?
    ) {
        self.description = description
        self.descriptions = descriptions
        self.`final` = `final`
        self.is_default = is_default
        self.is_system = is_system
        self.key = key
        self.labels = labels
        self.title = title
        self.tone = tone
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.`final` = try container.decodeIfPresent(Bool.self, forKey: .`final`)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.is_system = try container.decodeIfPresent(Bool.self, forKey: .is_system)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.ChannelVocabularyTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptions, forKey: .descriptions)
        try container.encodeIfPresent(`final`, forKey: .`final`)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(is_system, forKey: .is_system)
        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "descriptions": descriptions as Any,
            "final": `final` as Any,
            "is_default": is_default as Any,
            "is_system": is_system as Any,
            "key": key as Any,
            "labels": labels as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelVocabularyValue {
        return ChannelVocabularyValue(
            description: map["description"] as? [String: AnyCodable],
            descriptions: map["descriptions"] as? [String: AnyCodable],
            final: map["final"] as? Bool,
            is_default: map["is_default"] as? Bool,
            is_system: map["is_system"] as? Bool,
            key: map["key"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            title: map["title"] as? [String: AnyCodable],
            tone: map["tone"] as? String != nil ? ChannelVocabularyTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
