import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderVocabulary: Codable {

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
    /// True when the values are the complete permitted set — always, since the routes enforce the ones the schema does not.
    public let closed: Bool?
    /// The tone an unlabelled value gets.
    public let default_tone: RevenexxEnums.OrderVocabularyTone?
    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let description: String?
    /// Which vocabulary this is — echoed from the path, and the part after the dot in the qualified id.
    public let name: RevenexxEnums.OrderVocabularyName?
    /// Who enforces the set: 'schema' = a CHECK constraint, 'app' = the routes.
    public let source: RevenexxEnums.OrderVocabularySource?
    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let title: String?
    /// Every permitted value, in CONSTRAINT order — which for a status is lifecycle order, so a client can render them as a sequence without knowing one.
    public let values: [OrderVocabularyValue]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.OrderVocabularyTone?,
        description: String?,
        name: RevenexxEnums.OrderVocabularyName?,
        source: RevenexxEnums.OrderVocabularySource?,
        title: String?,
        values: [OrderVocabularyValue]?
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
            self.default_tone = RevenexxEnums.OrderVocabularyTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        if let nameString = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = RevenexxEnums.OrderVocabularyName(rawValue: nameString)
        } else {
            self.name = nil
        }
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.OrderVocabularySource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.values = try container.decodeIfPresent([OrderVocabularyValue].self, forKey: .values)
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

    public static func from(map: [String: Any] ) -> OrderVocabulary {
        return OrderVocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? OrderVocabularyTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? String,
            name: map["name"] as? String != nil ? OrderVocabularyName(rawValue: map["name"] as! String) : nil,
            source: map["source"] as? String != nil ? OrderVocabularySource(rawValue: map["source"] as! String) : nil,
            title: map["title"] as? String,
            values: (map["values"] as? [[String: Any]] ?? []).map { OrderVocabularyValue.from(map: $0) }
        )
    }
}
