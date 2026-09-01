import Foundation
import JSONCodable

/// 
open class ShippingVocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// The app that owns these vocabularies — the part before the dot in a qualified id.
    public let app: String?
    /// Every vocabulary this app publishes, without its values. Names only: fetch one to get the set.
    public let vocabularies: [ShippingVocabularyIndexEntry]?

    init(
        app: String?,
        vocabularies: [ShippingVocabularyIndexEntry]?
    ) {
        self.app = app
        self.vocabularies = vocabularies
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.vocabularies = try container.decodeIfPresent([ShippingVocabularyIndexEntry].self, forKey: .vocabularies)
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

    public static func from(map: [String: Any] ) -> ShippingVocabularyIndex {
        return ShippingVocabularyIndex(
            app: map["app"] as? String,
            vocabularies: (map["vocabularies"] as? [[String: Any]] ?? []).map { ShippingVocabularyIndexEntry.from(map: $0) }
        )
    }
}
