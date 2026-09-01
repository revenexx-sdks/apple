import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class InventoryVocabulary: Codable {

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
    /// True when these values are the complete permitted set, because they were read out of a CHECK constraint. A value outside a closed set is therefore stale data, not a missing label — which is what lets a client show it as an error instead of inventing a title for it.
    public let closed: Bool?
    /// The tone a value gets when nobody has labelled it — a value added to the CHECK constraint is served with its key humanized and this tone, rather than not being served at all.
    public let default_tone: RevenexxEnums.InventoryVocabularyDefaultTone?
    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// The vocabulary name, echoed — the part after the dot in the qualified id.
    public let name: String?
    /// Where the words come from: 'schema' — the app's own, read from the constraint. Nothing here is renameable per tenant, so a client may cache it per app version.
    public let source: RevenexxEnums.InventoryVocabularySource?
    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Every permitted value, IN CONSTRAINT ORDER — which is lifecycle order for a status, so a UI can render the steps in the order they happen.
    public let values: [[String: AnyCodable]]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.InventoryVocabularyDefaultTone?,
        description: [String: AnyCodable]?,
        name: String?,
        source: RevenexxEnums.InventoryVocabularySource?,
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
            self.default_tone = RevenexxEnums.InventoryVocabularyDefaultTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.InventoryVocabularySource(rawValue: sourceString)
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

    public static func from(map: [String: Any] ) -> InventoryVocabulary {
        return InventoryVocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? InventoryVocabularyDefaultTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String,
            source: map["source"] as? String != nil ? InventoryVocabularySource(rawValue: map["source"] as! String) : nil,
            title: map["title"] as? [String: AnyCodable],
            values: map["values"] as? [[String: AnyCodable]]
        )
    }
}
