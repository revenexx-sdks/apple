import Foundation
import JSONCodable

/// 
open class SegmentRuleRecomputeRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case cursor = "cursor"
    }

    /// Continuation token from a previous response — the id of the last organization the pass touched. Omit to resume or start automatically; pass null to force a restart from the beginning.
    public let cursor: String?

    init(
        cursor: String?
    ) {
        self.cursor = cursor
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cursor, forKey: .cursor)
    }

    public func toMap() -> [String: Any] {
        return [
            "cursor": cursor as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentRuleRecomputeRequest {
        return SegmentRuleRecomputeRequest(
            cursor: map["cursor"] as? String
        )
    }
}
