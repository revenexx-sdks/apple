import Foundation
import JSONCodable

/// 
open class SearchHit<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case document = "document"
        case highlight = "highlight"
        case text_match = "text_match"
        case data
    }

    /// The matching document; its properties are the collection's own fields.
    public let document: [String: AnyCodable]?
    /// Per-field highlight snippets, keyed by field name.
    public let highlight: [String: AnyCodable]?
    /// Relevance score.
    public let text_match: Int?
    /// Additional properties
    public let data: T

    init(
        document: [String: AnyCodable]?,
        highlight: [String: AnyCodable]?,
        text_match: Int?,
        data: T
    ) {
        self.document = document
        self.highlight = highlight
        self.text_match = text_match
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.document = try container.decodeIfPresent([String: AnyCodable].self, forKey: .document)
        self.highlight = try container.decodeIfPresent([String: AnyCodable].self, forKey: .highlight)
        self.text_match = try container.decodeIfPresent(Int.self, forKey: .text_match)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(document, forKey: .document)
        try container.encodeIfPresent(highlight, forKey: .highlight)
        try container.encodeIfPresent(text_match, forKey: .text_match)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "document": document as Any,
            "highlight": highlight as Any,
            "text_match": text_match as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> SearchHit {
        return SearchHit(
            document: map["document"] as? [String: AnyCodable],
            highlight: map["highlight"] as? [String: AnyCodable],
            text_match: map["text_match"] as? Int,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
