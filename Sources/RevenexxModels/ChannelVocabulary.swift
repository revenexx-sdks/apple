import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelVocabulary: Codable {

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
    /// Always true: the set is exhaustive at this moment, so a value outside it is stale data rather than a missing label. For a table-backed vocabulary that is a statement about now, not forever — the tenant may add to it.
    public let closed: Bool?
    /// The tone a value that carries none falls back to.
    public let default_tone: RevenexxEnums.ChannelVocabularyTone?
    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// Vocabulary name, unique within the app.
    public let name: RevenexxEnums.ChannelVocabularyName?
    /// Who owns the value set. 'schema' = a CHECK constraint in this app's own schema.json; 'table' = the tenant's own rows.
    public let source: RevenexxEnums.ChannelVocabularySource?
    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Every permitted value, in author order — the order a select should offer, not alphabetical. For a CHECK-backed vocabulary that is the constraint's own order; for the table-backed `types` it is the tenant's `position` order.
    public let values: [ChannelVocabularyValue]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.ChannelVocabularyTone?,
        description: [String: AnyCodable]?,
        name: RevenexxEnums.ChannelVocabularyName?,
        source: RevenexxEnums.ChannelVocabularySource?,
        title: [String: AnyCodable]?,
        values: [ChannelVocabularyValue]?
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
            self.default_tone = RevenexxEnums.ChannelVocabularyTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        if let nameString = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = RevenexxEnums.ChannelVocabularyName(rawValue: nameString)
        } else {
            self.name = nil
        }
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ChannelVocabularySource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        self.values = try container.decodeIfPresent([ChannelVocabularyValue].self, forKey: .values)
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

    public static func from(map: [String: Any] ) -> ChannelVocabulary {
        return ChannelVocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? ChannelVocabularyTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String != nil ? ChannelVocabularyName(rawValue: map["name"] as! String) : nil,
            source: map["source"] as? String != nil ? ChannelVocabularySource(rawValue: map["source"] as! String) : nil,
            title: map["title"] as? [String: AnyCodable],
            values: (map["values"] as? [[String: Any]] ?? []).map { ChannelVocabularyValue.from(map: $0) }
        )
    }
}
