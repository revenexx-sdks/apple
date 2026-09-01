import Foundation
import JSONCodable

/// 
open class VocabularyRef: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case name = "name"
        case title = "title"
    }

    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// The name to pass to `GET /products/vocabularies/{name}`.
    public let name: String?
    /// A plain string, or a locale map keyed by language tag ({ "en": …, "de": … }). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?

    init(
        description: [String: AnyCodable]?,
        name: String?,
        title: [String: AnyCodable]?
    ) {
        self.description = description
        self.name = name
        self.title = title
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
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

    public static func from(map: [String: Any] ) -> VocabularyRef {
        return VocabularyRef(
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String,
            title: map["title"] as? [String: AnyCodable]
        )
    }
}
