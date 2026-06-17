import Foundation
import JSONCodable

/// Languages List
open class LanguageList: Codable {

    enum CodingKeys: String, CodingKey {
        case languages = "languages"
        case total = "total"
    }

    /// List of languages.
    public let languages: [Language]
    /// Total number of languages that matched your query.
    public let total: Int

    init(
        languages: [Language],
        total: Int
    ) {
        self.languages = languages
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.languages = try container.decode([Language].self, forKey: .languages)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(languages, forKey: .languages)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "languages": languages.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LanguageList {
        return LanguageList(
            languages: (map["languages"] as! [[String: Any]]).map { Language.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
