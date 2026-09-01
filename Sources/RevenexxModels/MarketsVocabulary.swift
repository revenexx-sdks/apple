import Foundation
import JSONCodable
import RevenexxEnums

/// One closed value set this app owns, parsed out of the CHECK constraint in schema.json — the served set IS the enforced set. `closed: true` means a client may treat anything outside `values` as stale data.
open class MarketsVocabulary: Codable {

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
    /// Always true here: the values come from a CHECK constraint, so the list is exhaustive.
    public let closed: Bool?
    /// The tone a value that carries none falls back to.
    public let default_tone: RevenexxEnums.MarketsVocabularyTone?
    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let description: String?
    /// Vocabulary name, unique within the app.
    public let name: RevenexxEnums.MarketsVocabularyName?
    /// Where the values came from. 'schema' = a CHECK constraint in this app's own schema.json.
    public let source: RevenexxEnums.MarketsVocabularySource?
    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let title: String?
    /// Every value the column may hold, in the order the CHECK constraint lists them — which is the order a select box should offer them in. Exhaustive, because `closed` is true.
    public let values: [MarketsVocabularyValue]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.MarketsVocabularyTone?,
        description: String?,
        name: RevenexxEnums.MarketsVocabularyName?,
        source: RevenexxEnums.MarketsVocabularySource?,
        title: String?,
        values: [MarketsVocabularyValue]?
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
            self.default_tone = RevenexxEnums.MarketsVocabularyTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        if let nameString = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = RevenexxEnums.MarketsVocabularyName(rawValue: nameString)
        } else {
            self.name = nil
        }
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.MarketsVocabularySource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.values = try container.decodeIfPresent([MarketsVocabularyValue].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(closed, forKey: .closed)
        try container.encodeIfPresent(default_tone?.rawValue, forKey: .default_tone)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(name?.rawValue, forKey: .name)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
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
            "source": source?.rawValue as Any,
            "title": title as Any,
            "values": values?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketsVocabulary {
        return MarketsVocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? MarketsVocabularyTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? String,
            name: map["name"] as? String != nil ? MarketsVocabularyName(rawValue: map["name"] as! String) : nil,
            source: map["source"] as? String != nil ? MarketsVocabularySource(rawValue: map["source"] as! String) : nil,
            title: map["title"] as? String,
            values: (map["values"] as? [[String: Any]] ?? []).map { MarketsVocabularyValue.from(map: $0) }
        )
    }
}
