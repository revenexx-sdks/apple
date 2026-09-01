import Foundation
import JSONCodable
import RevenexxEnums

/// One enum this app owns, with every permitted value.
open class PaymentVocabulary: Codable {

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

    /// The app that owns this vocabulary — always `payments` here. Together with `name` it forms the platform-wide key `payments.statuses`.
    public let app: String?
    /// True when the set comes from a CHECK constraint and is therefore exhaustive — a client may treat anything outside it as stale data rather than a missing label.
    public let closed: Bool?
    /// The tone a permitted value nobody labelled falls back to, so every value is renderable.
    public let default_tone: RevenexxEnums.PaymentVocabularyTone?
    /// What this set of values is about. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// The vocabulary name, as it appears in the URL.
    public let name: String?
    /// Where the values come from. `schema` means they were parsed out of the CHECK constraint, so what is served is what the database enforces.
    public let source: String?
    /// The vocabulary's own label, for a filter heading or a column title. A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?
    /// Every permitted value, in constraint order — which is the lifecycle order an author wrote, and the order a select should offer.
    public let values: [PaymentVocabularyValue]?

    init(
        app: String?,
        closed: Bool?,
        default_tone: RevenexxEnums.PaymentVocabularyTone?,
        description: [String: AnyCodable]?,
        name: String?,
        source: String?,
        title: [String: AnyCodable]?,
        values: [PaymentVocabularyValue]?
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
            self.default_tone = RevenexxEnums.PaymentVocabularyTone(rawValue: default_toneString)
        } else {
            self.default_tone = nil
        }
        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
        self.values = try container.decodeIfPresent([PaymentVocabularyValue].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(closed, forKey: .closed)
        try container.encodeIfPresent(default_tone?.rawValue, forKey: .default_tone)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(name, forKey: .name)
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
            "name": name as Any,
            "source": source as Any,
            "title": title as Any,
            "values": values?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentVocabulary {
        return PaymentVocabulary(
            app: map["app"] as? String,
            closed: map["closed"] as? Bool,
            default_tone: map["default_tone"] as? String != nil ? PaymentVocabularyTone(rawValue: map["default_tone"] as! String) : nil,
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String,
            source: map["source"] as? String,
            title: map["title"] as? [String: AnyCodable],
            values: (map["values"] as? [[String: Any]] ?? []).map { PaymentVocabularyValue.from(map: $0) }
        )
    }
}
