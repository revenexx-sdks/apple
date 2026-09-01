import Foundation
import JSONCodable

/// Where this page sits in the full result set. Rows beyond `limit` are not returned and are not lost — ask for the next page with `offset`.
open class PricePage: Codable {

    enum CodingKeys: String, CodingKey {
        case hasMore = "hasMore"
        case limit = "limit"
        case offset = "offset"
        case returned = "returned"
        case total = "total"
    }

    /// true when `offset + returned < total` — there is another page to fetch.
    public let hasMore: Bool?
    /// Page size actually applied — the `limit` you sent, clamped to 1…200 (default 50).
    public let limit: Int?
    /// Row offset actually applied (default 0).
    public let offset: Int?
    /// Rows in `items` on this page.
    public let returned: Int?
    /// Rows matching the filter across all pages, not just this one.
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

    public static func from(map: [String: Any] ) -> PricePage {
        return PricePage(
            hasMore: map["hasMore"] as? Bool,
            limit: map["limit"] as? Int,
            offset: map["offset"] as? Int,
            returned: map["returned"] as? Int,
            total: map["total"] as? Int
        )
    }
}
