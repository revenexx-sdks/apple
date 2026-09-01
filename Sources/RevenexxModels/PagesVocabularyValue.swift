import Foundation
import JSONCodable
import RevenexxEnums

/// One permitted value of a vocabulary, with everything needed to render it.
open class PagesVocabularyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case `final` = "final"
        case key = "key"
        case title = "title"
        case tone = "tone"
    }

    /// When to use this value, or null when nobody wrote one. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// The value ends the lifecycle.
    public let `final`: Bool?
    /// The value as the database stores and enforces it.
    public let key: String?
    /// What a person reads. Falls back to a humanized key. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Semantic badge colour. The client owns what each tone looks like.
    public let tone: RevenexxEnums.PagesVocabularyTone?

    init(
        description: [String: AnyCodable]?,
        `final`: Bool?,
        key: String?,
        title: [String: AnyCodable]?,
        tone: RevenexxEnums.PagesVocabularyTone?
    ) {
        self.description = description
        self.`final` = `final`
        self.key = key
        self.title = title
        self.tone = tone
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        self.`final` = try container.decodeIfPresent(Bool.self, forKey: .`final`)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.PagesVocabularyTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(`final`, forKey: .`final`)
        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "final": `final` as Any,
            "key": key as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PagesVocabularyValue {
        return PagesVocabularyValue(
            description: map["description"] as? [String: AnyCodable],
            final: map["final"] as? Bool,
            key: map["key"] as? String,
            title: map["title"] as? [String: AnyCodable],
            tone: map["tone"] as? String != nil ? PagesVocabularyTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
