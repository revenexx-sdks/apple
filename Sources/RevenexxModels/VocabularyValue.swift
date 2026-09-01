import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class VocabularyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case `final` = "final"
        case key = "key"
        case title = "title"
        case tone = "tone"
    }

    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// A terminal state — nothing moves out of it. False or absent on a vocabulary that is not a lifecycle.
    public let `final`: Bool?
    /// The value as it is STORED and as the CHECK admits it — what a filter or a write sends.
    public let key: String?
    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Which badge colour a UI should paint this value in.
    public let tone: RevenexxEnums.VocabularyTone?

    init(
        description: [String: AnyCodable]?,
        `final`: Bool?,
        key: String?,
        title: [String: AnyCodable]?,
        tone: RevenexxEnums.VocabularyTone?
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
            self.tone = RevenexxEnums.VocabularyTone(rawValue: toneString)
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

    public static func from(map: [String: Any] ) -> VocabularyValue {
        return VocabularyValue(
            description: map["description"] as? [String: AnyCodable],
            final: map["final"] as? Bool,
            key: map["key"] as? String,
            title: map["title"] as? [String: AnyCodable],
            tone: map["tone"] as? String != nil ? VocabularyTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
