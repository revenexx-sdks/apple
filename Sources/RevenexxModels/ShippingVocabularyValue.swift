import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ShippingVocabularyValue: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case descriptions = "descriptions"
        case factor = "factor"
        case `final` = "final"
        case is_base = "is_base"
        case is_default = "is_default"
        case is_system = "is_system"
        case key = "key"
        case labels = "labels"
        case title = "title"
        case tone = "tone"
    }

    /// What the value means. Either one string or a locale map keyed by locale (e.g. {en, de}) — curated copy carries the map, a value falling back to its own key carries the string.
    public let description: String?
    /// Table-backed only: localized descriptions, keyed by locale.
    public let descriptions: [String: AnyCodable]?
    /// weight-units only: kilograms per unit. A weight vocabulary without it is a list of names you cannot convert with.
    public let factor: Double?
    /// The value ends the lifecycle.
    public let `final`: Bool?
    /// weight-units only: the unit every other factor is expressed in.
    public let is_base: Bool?
    /// Table-backed only: the value a caller falls back to, so a client can mark it without reading the settings as well.
    public let is_default: Bool?
    /// Table-backed only: seeded on install. Still renameable and retirable.
    public let is_system: Bool?
    /// The value as the database stores it — what a column carries and what a filter matches. The only field a machine should compare on.
    public let key: String?
    /// Table-backed only: localized titles, keyed by locale. Absent for a vocabulary whose values come from a CHECK constraint — those carry their copy in `title` instead.
    public let labels: [String: AnyCodable]?
    /// What a person reads. Falls back to a humanized key. Either one string or a locale map keyed by locale (e.g. {en, de}) — curated copy carries the map, a value falling back to its own key carries the string.
    public let title: String?
    /// Semantic badge colour. The client owns what each tone looks like.
    public let tone: RevenexxEnums.ShippingVocabularyTone?

    init(
        description: String?,
        descriptions: [String: AnyCodable]?,
        factor: Double?,
        `final`: Bool?,
        is_base: Bool?,
        is_default: Bool?,
        is_system: Bool?,
        key: String?,
        labels: [String: AnyCodable]?,
        title: String?,
        tone: RevenexxEnums.ShippingVocabularyTone?
    ) {
        self.description = description
        self.descriptions = descriptions
        self.factor = factor
        self.`final` = `final`
        self.is_base = is_base
        self.is_default = is_default
        self.is_system = is_system
        self.key = key
        self.labels = labels
        self.title = title
        self.tone = tone
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .descriptions)
        self.factor = try container.decodeIfPresent(Double.self, forKey: .factor)
        self.`final` = try container.decodeIfPresent(Bool.self, forKey: .`final`)
        self.is_base = try container.decodeIfPresent(Bool.self, forKey: .is_base)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.is_system = try container.decodeIfPresent(Bool.self, forKey: .is_system)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        if let toneString = try container.decodeIfPresent(String.self, forKey: .tone) {
            self.tone = RevenexxEnums.ShippingVocabularyTone(rawValue: toneString)
        } else {
            self.tone = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(descriptions, forKey: .descriptions)
        try container.encodeIfPresent(factor, forKey: .factor)
        try container.encodeIfPresent(`final`, forKey: .`final`)
        try container.encodeIfPresent(is_base, forKey: .is_base)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(is_system, forKey: .is_system)
        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(tone?.rawValue, forKey: .tone)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "descriptions": descriptions as Any,
            "factor": factor as Any,
            "final": `final` as Any,
            "is_base": is_base as Any,
            "is_default": is_default as Any,
            "is_system": is_system as Any,
            "key": key as Any,
            "labels": labels as Any,
            "title": title as Any,
            "tone": tone?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingVocabularyValue {
        return ShippingVocabularyValue(
            description: map["description"] as? String,
            descriptions: map["descriptions"] as? [String: AnyCodable],
            factor: map["factor"] as? Double,
            final: map["final"] as? Bool,
            is_base: map["is_base"] as? Bool,
            is_default: map["is_default"] as? Bool,
            is_system: map["is_system"] as? Bool,
            key: map["key"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            title: map["title"] as? String,
            tone: map["tone"] as? String != nil ? ShippingVocabularyTone(rawValue: map["tone"] as! String) : nil
        )
    }
}
