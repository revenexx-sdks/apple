import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class Vocabulary: Codable {

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

    /// This app's name — the part before the dot in the qualified id.
    public let app: String?
    /// True when the values are the complete permitted set. For a CHECK-backed vocabulary the constraint guarantees it; for a table-backed one the app refuses a value outside the rows, and for `locales` outside the configured list — the same guarantee by three mechanisms.
    public let closed: Bool?
    /// The tone an unlabelled value gets.
    public let default_tone: RevenexxEnums.VocabularyDefaultTone?
    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`. A curated label is a map; a value nobody labelled is humanized into a plain string.
    public let description: [String: AnyCodable]?
    /// The vocabulary this is.
    public let name: String?
    /// 'schema' — a CHECK constraint owns the set. 'table' — the tenant's own rows do. 'defaults' — a table-backed set the tenant never wrote down, answered from the built-ins. 'tenant' — the merchant configured the values through a setting (locales).
    public let source: RevenexxEnums.VocabularySource?
    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`. A curated label is a map; a value nobody labelled is humanized into a plain string.
    public let title: [String: AnyCodable]?
    /// Every permitted value, in the order a select should offer them.
    public let values: [[String: AnyCodable]]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.VocabularyDefaultTone?,
        description: [String: AnyCodable]?,
        name: String?,
        source: RevenexxEnums.VocabularySource?,
        title: [String: AnyCodable]?,
        values: [[String: AnyCodable]]?
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
            self.default_tone = RevenexxEnums.VocabularyDefaultTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.VocabularySource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        self.values = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(closed, forKey: .closed)
        try container.encodeIfPresent(default_tone?.rawValue, forKey: .default_tone)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(name, forKey: .name)
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
            "name": name as Any,
            "source": source?.rawValue as Any,
            "title": title as Any,
            "values": values as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Vocabulary {
        return Vocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? VocabularyDefaultTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String,
            source: map["source"] as? String != nil ? VocabularySource(rawValue: map["source"] as! String) : nil,
            title: map["title"] as? [String: AnyCodable],
            values: map["values"] as? [[String: AnyCodable]]
        )
    }
}
