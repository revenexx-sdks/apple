import Foundation
import JSONCodable

/// 
open class OrderVocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// This app's name — the part before the dot in the qualified id.
    public let app: String?
    /// Every vocabulary this app publishes, without its values — fetch one with GET /orders/vocabularies/{name}.
    public let vocabularies: [OrderVocabularySummary]?

    init(
        app: String?,
        vocabularies: [OrderVocabularySummary]?
    ) {
        self.app = app
        self.vocabularies = vocabularies
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.vocabularies = try container.decodeIfPresent([OrderVocabularySummary].self, forKey: .vocabularies)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(vocabularies, forKey: .vocabularies)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app as Any,
            "vocabularies": vocabularies?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderVocabularyIndex {
        return OrderVocabularyIndex(
            app: map["app"] as? String,
            vocabularies: (map["vocabularies"] as? [[String: Any]] ?? []).map { OrderVocabularySummary.from(map: $0) }
        )
    }
}
