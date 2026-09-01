import Foundation
import JSONCodable

/// 
open class FormsVocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// The app that owns this vocabulary.
    public let app: String?
    /// Every vocabulary this app publishes, without its values — enough to build a menu, not enough to fill a select. Fetch one by name for that.
    public let vocabularies: [FormsVocabularySummary]?

    init(
        app: String?,
        vocabularies: [FormsVocabularySummary]?
    ) {
        self.app = app
        self.vocabularies = vocabularies
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.vocabularies = try container.decodeIfPresent([FormsVocabularySummary].self, forKey: .vocabularies)
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

    public static func from(map: [String: Any] ) -> FormsVocabularyIndex {
        return FormsVocabularyIndex(
            app: map["app"] as? String,
            vocabularies: (map["vocabularies"] as? [[String: Any]] ?? []).map { FormsVocabularySummary.from(map: $0) }
        )
    }
}
