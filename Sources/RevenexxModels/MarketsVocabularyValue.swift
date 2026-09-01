import Foundation
import JSONCodable
import RevenexxEnums

/// One permitted value, with the copy and the badge tone a client renders it as.
open class MarketsVocabularyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case `final` = "final"
        case key = "key"
        case title = "title"
        case tone = "tone"
    }

    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let description: String?
    /// A terminal state nothing moves out of.
    public let `final`: Bool?
    /// The value as stored in the column.
    public let key: String?
    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let title: String?
    /// Semantic badge tone — the client decides what it looks like.
    public let tone: RevenexxEnums.MarketsVocabularyTone?

    init(
        description: String?,
        `final`: Bool?,
        key: String?,
        title: String?,
        tone: RevenexxEnums.MarketsVocabularyTone?
    ) {
        self.description = description
        self.`final` = `final`
        self.key = key
        self.title = title
        self.tone = tone
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.`final` = try container.decodeIfPresent(Bool.self, forKey: .`final`)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.MarketsVocabularyTone(rawValue: toneString)
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

    public static func from(map: [String: Any] ) -> MarketsVocabularyValue {
        return MarketsVocabularyValue(
            description: map["description"] as? String,
            final: map["final"] as? Bool,
            key: map["key"] as? String,
            title: map["title"] as? String,
            tone: map["tone"] as? String != nil ? MarketsVocabularyTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
