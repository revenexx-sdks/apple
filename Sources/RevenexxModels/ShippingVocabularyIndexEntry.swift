import Foundation
import JSONCodable

/// One vocabulary, named and titled.
open class ShippingVocabularyIndexEntry: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case name = "name"
        case title = "title"
    }

    /// What the vocabulary is for. Either one string or a locale map keyed by locale (e.g. {en, de}) — curated copy carries the map, a value falling back to its own key carries the string.
    public let description: String?
    /// The part after the dot in the qualified id — what GET /shipping/vocabularies/{name} takes.
    public let name: String?
    /// What the vocabulary is called. Either one string or a locale map keyed by locale (e.g. {en, de}) — curated copy carries the map, a value falling back to its own key carries the string.
    public let title: String?

    init(
        description: String?,
        name: String?,
        title: String?
    ) {
        self.description = description
        self.name = name
        self.title = title
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(title, forKey: .title)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "name": name as Any,
            "title": title as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingVocabularyIndexEntry {
        return ShippingVocabularyIndexEntry(
            description: map["description"] as? String,
            name: map["name"] as? String,
            title: map["title"] as? String
        )
    }
}
