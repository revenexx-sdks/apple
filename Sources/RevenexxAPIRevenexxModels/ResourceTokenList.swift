import Foundation
import JSONCodable

/// Resource Tokens List
open class ResourceTokenList: Codable {

    enum CodingKeys: String, CodingKey {
        case tokens = "tokens"
        case total = "total"
    }

    /// List of tokens.
    public let tokens: [ResourceToken]
    /// Total number of tokens that matched your query.
    public let total: Int

    init(
        tokens: [ResourceToken],
        total: Int
    ) {
        self.tokens = tokens
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.tokens = try container.decode([ResourceToken].self, forKey: .tokens)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(tokens, forKey: .tokens)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "tokens": tokens.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ResourceTokenList {
        return ResourceTokenList(
            tokens: (map["tokens"] as! [[String: Any]]).map { ResourceToken.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
