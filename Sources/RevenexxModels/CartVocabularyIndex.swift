import Foundation
import JSONCodable

/// 
open class CartVocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// The app that owns this vocabulary.
    public let app: String?
    /// Every vocabulary this app publishes, without its values — enough to build a menu, and one call per vocabulary to fill it.
    public let vocabularies: [CartVocabularyRef]?

    init(
        app: String?,
        vocabularies: [CartVocabularyRef]?
    ) {
        self.app = app
        self.vocabularies = vocabularies
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.vocabularies = try container.decodeIfPresent([CartVocabularyRef].self, forKey: .vocabularies)
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

    public static func from(map: [String: Any] ) -> CartVocabularyIndex {
        return CartVocabularyIndex(
            app: map["app"] as? String,
            vocabularies: (map["vocabularies"] as? [[String: Any]] ?? []).map { CartVocabularyRef.from(map: $0) }
        )
    }
}
