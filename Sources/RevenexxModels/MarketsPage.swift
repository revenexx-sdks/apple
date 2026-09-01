import Foundation
import JSONCodable

/// Where in the result set this answer sits. `limit` and `offset` are the values that were APPLIED, not the ones that were asked for — the data plane clamps rather than refuses, so an out-of-range or unparseable value comes back corrected here instead of as a 400.
open class MarketsPage: Codable {

    enum CodingKeys: String, CodingKey {
        case hasMore = "hasMore"
        case limit = "limit"
        case offset = "offset"
        case returned = "returned"
        case total = "total"
    }

    /// True when `offset + returned < total`, i.e. another page exists. Cheaper to branch on than comparing the three numbers yourself.
    public let hasMore: Bool?
    /// Page size actually applied. A request over 200 is clamped to 200, one under 1 (or one that is not a number) to the 50-row default.
    public let limit: Int?
    /// Row offset actually applied. A negative offset is clamped to 0.
    public let offset: Int?
    /// Rows in `items` on this page. Lower than `limit` on the last page.
    public let returned: Int?
    /// Rows matching the filter across ALL pages, ignoring limit and offset — the number to paginate against.
    public let total: Int?

    init(
        hasMore: Bool?,
        limit: Int?,
        offset: Int?,
        returned: Int?,
        total: Int?
    ) {
        self.hasMore = hasMore
        self.limit = limit
        self.offset = offset
        self.returned = returned
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.hasMore = try container.decodeIfPresent(Bool.self, forKey: .hasMore)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        self.returned = try container.decodeIfPresent(Int.self, forKey: .returned)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(hasMore, forKey: .hasMore)
        try container.encodeIfPresent(limit, forKey: .limit)
        try container.encodeIfPresent(offset, forKey: .offset)
        try container.encodeIfPresent(returned, forKey: .returned)
        try container.encodeIfPresent(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "hasMore": hasMore as Any,
            "limit": limit as Any,
            "offset": offset as Any,
            "returned": returned as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketsPage {
        return MarketsPage(
            hasMore: map["hasMore"] as? Bool,
            limit: map["limit"] as? Int,
            offset: map["offset"] as? Int,
            returned: map["returned"] as? Int,
            total: map["total"] as? Int
        )
    }
}
