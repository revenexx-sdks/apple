import Foundation
import JSONCodable
import RevenexxEnums

/// One vocabulary, enough to list it in a menu.
open class MarketsVocabularySummary: Codable {

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case name = "name"
        case title = "title"
    }

    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let description: String?
    /// Vocabulary name, unique within the app.
    public let name: RevenexxEnums.MarketsVocabularySummaryName?
    /// Either one string, or a map of locale to string ({"en": …, "de": …}).
    public let title: String?

    init(
        description: String?,
        name: RevenexxEnums.MarketsVocabularySummaryName?,
        title: String?
    ) {
        self.description = description
        self.name = name
        self.title = title
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        if let nameString = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = RevenexxEnums.MarketsVocabularySummaryName(rawValue: nameString)
        } else {
            self.name = nil
        }
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
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

    public static func from(map: [String: Any] ) -> MarketsVocabularySummary {
        return MarketsVocabularySummary(
            description: map["description"] as? String,
            name: map["name"] as? String != nil ? MarketsVocabularySummaryName(rawValue: map["name"] as! String) : nil,
            title: map["title"] as? String
        )
    }
}
