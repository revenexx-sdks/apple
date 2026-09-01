import Foundation
import JSONCodable
import RevenexxEnums

/// Which vocabularies this app publishes.
open class PagesVocabularyIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case vocabularies = "vocabularies"
    }

    /// Always 'pages' — the first half of the qualified id a client holds.
    public let app: RevenexxEnums.PagesVocabularyIndexApp?
    /// One entry per vocabulary, without its values.
    public let vocabularies: [PagesVocabularyRef]?

    init(
        app: RevenexxEnums.PagesVocabularyIndexApp?,
        vocabularies: [PagesVocabularyRef]?
    ) {
        self.app = app
        self.vocabularies = vocabularies
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let appString = try container.decodeIfPresent(String.self, forKey: .app) {
            self.app = RevenexxEnums.PagesVocabularyIndexApp(rawValue: appString)
        } else {
            self.app = nil
        }
        self.vocabularies = try container.decodeIfPresent([PagesVocabularyRef].self, forKey: .vocabularies)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app?.rawValue, forKey: .app)
        try container.encodeIfPresent(vocabularies, forKey: .vocabularies)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app?.rawValue as Any,
            "vocabularies": vocabularies?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PagesVocabularyIndex {
        return PagesVocabularyIndex(
            app: map["app"] as? String != nil ? PagesVocabularyIndexApp(rawValue: map["app"] as! String) : nil,
            vocabularies: (map["vocabularies"] as? [[String: Any]] ?? []).map { PagesVocabularyRef.from(map: $0) }
        )
    }
}
