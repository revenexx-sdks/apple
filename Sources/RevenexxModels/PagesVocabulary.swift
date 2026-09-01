import Foundation
import JSONCodable
import RevenexxEnums

/// One vocabulary and every value it permits.
open class PagesVocabulary: Codable {

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

    /// Always 'pages'.
    public let app: RevenexxEnums.PagesVocabularyApp?
    /// The set is exhaustive, so a value outside it is stale data rather than a missing label.
    public let closed: Bool?
    /// The badge colour a value nobody toned falls back to.
    public let default_tone: RevenexxEnums.PagesVocabularyTone?
    /// What the set is for, or null. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// The vocabulary name, echoed.
    public let name: RevenexxEnums.PagesVocabularyName?
    /// Always 'schema' — the values are parsed from the column's CHECK constraint, which is why the served set cannot drift from the enforced one.
    public let source: RevenexxEnums.PagesVocabularySource?
    /// What this set of values is called. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Every permitted value, in the order the constraint lists them — which is the order a select should offer.
    public let values: [PagesVocabularyValue]?

    init(
        app: RevenexxEnums.PagesVocabularyApp?,
        closed: Bool?,
        default_tone: RevenexxEnums.PagesVocabularyTone?,
        description: [String: AnyCodable]?,
        name: RevenexxEnums.PagesVocabularyName?,
        source: RevenexxEnums.PagesVocabularySource?,
        title: [String: AnyCodable]?,
        values: [PagesVocabularyValue]?
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

        if let appString = try container.decodeIfPresent(String.self, forKey: .app) {
            self.app = RevenexxEnums.PagesVocabularyApp(rawValue: appString)
        } else {
            self.app = nil
        }
        self.closed = try container.decodeIfPresent(Bool.self, forKey: .closed)
        if let default_toneString = try container.decodeIfPresent(String.self, forKey: .default_tone) {
            self.default_tone = RevenexxEnums.PagesVocabularyTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        if let nameString = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = RevenexxEnums.PagesVocabularyName(rawValue: nameString)
        } else {
            self.name = nil
        }
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.PagesVocabularySource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        self.values = try container.decodeIfPresent([PagesVocabularyValue].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app?.rawValue, forKey: .app)
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
            "app": app?.rawValue as Any,
            "closed": closed as Any,
            "default_tone": default_tone?.rawValue as Any,
            "description": description as Any,
            "name": name?.rawValue as Any,
            "source": source?.rawValue as Any,
            "title": title as Any,
            "values": values?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PagesVocabulary {
        return PagesVocabulary(
            app: map["app"] as? String != nil ? PagesVocabularyApp(rawValue: map["app"] as! String) : nil,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? PagesVocabularyTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String != nil ? PagesVocabularyName(rawValue: map["name"] as! String) : nil,
            source: map["source"] as? String != nil ? PagesVocabularySource(rawValue: map["source"] as! String) : nil,
            title: map["title"] as? [String: AnyCodable],
            values: (map["values"] as? [[String: Any]] ?? []).map { PagesVocabularyValue.from(map: $0) }
        )
    }
}
