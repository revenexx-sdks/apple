import Foundation
import JSONCodable

/// What this app publishes, without the values — one fetch a UI can cache and then pull only the vocabularies it renders.
open class PriceVocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// The app that owns this vocabulary.
    public let app: String?
    /// Every vocabulary this app owns, sorted by name.
    public let vocabularies: [PriceVocabularyRef]?

    init(
        app: String?,
        vocabularies: [PriceVocabularyRef]?
    ) {
        self.app = app
        self.vocabularies = vocabularies
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.vocabularies = try container.decodeIfPresent([PriceVocabularyRef].self, forKey: .vocabularies)
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

    public static func from(map: [String: Any] ) -> PriceVocabularyIndex {
        return PriceVocabularyIndex(
            app: map["app"] as? String,
            vocabularies: (map["vocabularies"] as? [[String: Any]] ?? []).map { PriceVocabularyRef.from(map: $0) }
        )
    }
}
