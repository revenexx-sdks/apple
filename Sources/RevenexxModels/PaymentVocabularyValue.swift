import Foundation
import JSONCodable
import RevenexxEnums

/// One permitted value, with the words and the colour a human reads for it.
open class PaymentVocabularyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case `final` = "final"
        case key = "key"
        case title = "title"
        case tone = "tone"
    }

    /// One sentence on what the value means, or null where the key speaks for itself. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// This value ends the lifecycle — the honest way to ask "is this still open?" instead of matching status names.
    public let `final`: Bool?
    /// The value exactly as the database stores it — what a filter sends and what a row carries.
    public let key: String?
    /// The label to show for this value. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// What the state MEANS, semantically: neutral, info, success, warning or danger. The client decides what each one looks like in its own design system.
    public let tone: RevenexxEnums.PaymentVocabularyTone?

    init(
        description: [String: AnyCodable]?,
        `final`: Bool?,
        key: String?,
        title: [String: AnyCodable]?,
        tone: RevenexxEnums.PaymentVocabularyTone?
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
            self.tone = RevenexxEnums.PaymentVocabularyTone(rawValue: toneString)
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

    public static func from(map: [String: Any] ) -> PaymentVocabularyValue {
        return PaymentVocabularyValue(
            description: map["description"] as? [String: AnyCodable],
            final: map["final"] as? Bool,
            key: map["key"] as? String,
            title: map["title"] as? [String: AnyCodable],
            tone: map["tone"] as? String != nil ? PaymentVocabularyTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
