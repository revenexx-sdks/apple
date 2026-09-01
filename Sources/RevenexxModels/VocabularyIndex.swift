import Foundation
import JSONCodable

/// 
open class VocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// This app's name — the part before the dot in the qualified id `customers.<name>`.
    public let app: String?
    /// Every vocabulary this app publishes, without their values.
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

    public static func from(map: [String: Any] ) -> VocabularyIndex {
        return VocabularyIndex(
            app: map["app"] as? String,
            vocabularies: map["vocabularies"] as? [[String: AnyCodable]]
        )
    }
}
