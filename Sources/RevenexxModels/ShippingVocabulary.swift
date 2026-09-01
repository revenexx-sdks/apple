import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ShippingVocabulary: Codable {

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
    /// The set is exhaustive, so a value outside it is stale data rather than a missing label. True either way — what differs is who may extend it.
    public let closed: Bool?
    /// The badge colour a value that names none falls back to.
    public let default_tone: RevenexxEnums.ShippingVocabularyDefaultTone?
    /// What the vocabulary is for. Either one string or a locale map keyed by locale (e.g. {en, de}) — curated copy carries the map, a value falling back to its own key carries the string.
    public let description: String?
    /// The vocabulary name — the part after the dot in the qualified id.
    public let name: String?
    /// 'schema' — the values are a CHECK constraint's, so the served set IS the enforced set. 'table' — the values are the tenant's own rows, read per request.
    public let source: RevenexxEnums.ShippingVocabularySource?
    /// What the vocabulary is called. Either one string or a locale map keyed by locale (e.g. {en, de}) — curated copy carries the map, a value falling back to its own key carries the string.
    public let title: String?
    /// Every permitted value, in the order a select should offer them — constraint order for a schema vocabulary, `position` for a table one.
    public let values: [ShippingVocabularyValue]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.ShippingVocabularyDefaultTone?,
        description: String?,
        name: String?,
        source: RevenexxEnums.ShippingVocabularySource?,
        title: String?,
        values: [ShippingVocabularyValue]?
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
            self.default_tone = RevenexxEnums.ShippingVocabularyDefaultTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ShippingVocabularySource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.values = try container.decodeIfPresent([ShippingVocabularyValue].self, forKey: .values)
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
            "values": values?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingVocabulary {
        return ShippingVocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? ShippingVocabularyDefaultTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? String,
            name: map["name"] as? String,
            source: map["source"] as? String != nil ? ShippingVocabularySource(rawValue: map["source"] as! String) : nil,
            title: map["title"] as? String,
            values: (map["values"] as? [[String: Any]] ?? []).map { ShippingVocabularyValue.from(map: $0) }
        )
    }
}
