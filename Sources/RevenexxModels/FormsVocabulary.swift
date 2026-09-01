import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class FormsVocabulary: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case closed = "closed"
        case default_tone = "default_tone"
        case description = "description"
        case name = "name"
        case source = "source"
        case title = "title"
        case values = "values"
    }

    /// The app that owns this vocabulary.
    public let app: String?
    /// The set is exhaustive.
    public let closed: Bool?
    /// The tone a value nobody gave one falls back to — what a badge looks like for a status that was added to the CHECK constraint before anyone styled it.
    public let default_tone: RevenexxEnums.FormsVocabularyTone?
    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// Vocabulary name, unique within the app.
    public let name: RevenexxEnums.FormsVocabularyName?
    /// Parsed from the CHECK constraint.
    public let source: String?
    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Every permitted value, in constraint order — which is the order a select should offer them in, because it is the lifecycle order.
    public let values: [FormsVocabularyValue]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.FormsVocabularyTone?,
        description: [String: AnyCodable]?,
        name: RevenexxEnums.FormsVocabularyName?,
        source: String?,
        title: [String: AnyCodable]?,
        values: [FormsVocabularyValue]?
    ) {
        self.app = app
        self.closed = closed
        self.default_tone = default_tone
        self.description = description
        self.name = name
        self.source = source
        self.title = title
        self.values = values
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.closed = try container.decodeIfPresent(Bool.self, forKey: .closed)
        if let default_toneString = try container.decodeIfPresent(String.self, forKey: .default_tone) {
            self.default_tone = RevenexxEnums.FormsVocabularyTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        if let nameString = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = RevenexxEnums.FormsVocabularyName(rawValue: nameString)
        } else {
            self.name = nil
        }
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        self.values = try container.decodeIfPresent([FormsVocabularyValue].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(closed, forKey: .closed)
        try container.encodeIfPresent(default_tone?.rawValue, forKey: .default_tone)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(name?.rawValue, forKey: .name)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(values, forKey: .values)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app as Any,
            "closed": closed as Any,
            "default_tone": default_tone?.rawValue as Any,
            "description": description as Any,
            "name": name?.rawValue as Any,
            "source": source as Any,
            "title": title as Any,
            "values": values?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormsVocabulary {
        return FormsVocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? FormsVocabularyTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String != nil ? FormsVocabularyName(rawValue: map["name"] as! String) : nil,
            source: map["source"] as? String,
            title: map["title"] as? [String: AnyCodable],
            values: (map["values"] as? [[String: Any]] ?? []).map { FormsVocabularyValue.from(map: $0) }
        )
    }
}
