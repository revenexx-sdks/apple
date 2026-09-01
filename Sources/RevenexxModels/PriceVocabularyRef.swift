import Foundation
import JSONCodable
import RevenexxEnums

/// One vocabulary, named and titled — fetch its values with GET /prices/vocabularies/{name}.
open class PriceVocabularyRef: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case name = "name"
        case title = "title"
    }

    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let description: [String: AnyCodable]?
    /// Vocabulary name, unique within the app.
    public let name: RevenexxEnums.PriceVocabularyRefName?
    /// A plain string, or a locale map keyed by language tag ({"en": …, "de": …}). Read the requested tag, fall back to `en`.
    public let title: [String: AnyCodable]?

    init(
        description: [String: AnyCodable]?,
        name: RevenexxEnums.PriceVocabularyRefName?,
        title: [String: AnyCodable]?
    ) {
        self.description = description
        self.name = name
        self.title = title
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent([String: AnyCodable].self, forKey: .description)
        if let nameString = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = RevenexxEnums.PriceVocabularyRefName(rawValue: nameString)
        } else {
            self.name = nil
        }
        self.title = try container.decodeIfPresent([String: AnyCodable].self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(name?.rawValue, forKey: .name)
        try container.encodeIfPresent(title, forKey: .title)
    }

    public func toMap() -> [String: Any] {
        return [
            "description": description as Any,
            "name": name?.rawValue as Any,
            "title": title as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceVocabularyRef {
        return PriceVocabularyRef(
            description: map["description"] as? [String: AnyCodable],
            name: map["name"] as? String != nil ? PriceVocabularyRefName(rawValue: map["name"] as! String) : nil,
            title: map["title"] as? [String: AnyCodable]
        )
    }
}
