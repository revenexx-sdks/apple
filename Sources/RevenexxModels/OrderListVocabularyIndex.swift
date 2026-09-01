import Foundation
import JSONCodable

/// 
open class OrderListVocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// The app that owns this vocabulary.
    public let app: String?
    /// Every vocabulary this app publishes, without its values — the values are one call further down, at GET /orderlists/vocabularies/{name}.
    public let vocabularies: [[String: AnyCodable]]?

    init(
        app: String?,
        vocabularies: [[String: AnyCodable]]?
    ) {
        self.app = app
        self.vocabularies = vocabularies
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.vocabularies = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .vocabularies)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(vocabularies, forKey: .vocabularies)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app as Any,
            "vocabularies": vocabularies as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListVocabularyIndex {
        return OrderListVocabularyIndex(
            app: map["app"] as? String,
            vocabularies: map["vocabularies"] as? [[String: AnyCodable]]
        )
    }
}
