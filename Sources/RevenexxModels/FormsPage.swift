import Foundation
import JSONCodable

/// Where this page sits in the result set. Everything needed to fetch the next one is here, so a client never has to guess whether it has seen everything.
open class FormsPage: Codable {

    enum CodingKeys: String, CodingKey {
        case hasMore = "hasMore"
        case limit = "limit"
        case offset = "offset"
        case returned = "returned"
        case total = "total"
    }

    /// True while `offset + returned < total`: another page follows, at `offset + returned`.
    public let hasMore: Bool?
    /// The page size that was applied — the `limit` parameter after clamping to 1…200, or 50 when none was given.
    public let limit: Int?
    /// How many matching rows were skipped before this page.
    public let offset: Int?
    /// How many rows are in `items` — below `limit` exactly on the last page.
    public let returned: Int?
    /// How many rows match the filter in total, ignoring the page. This is the number to show a merchant; `returned` is only what fitted.
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

    public static func from(map: [String: Any] ) -> FormsPage {
        return FormsPage(
            hasMore: map["hasMore"] as? Bool,
            limit: map["limit"] as? Int,
            offset: map["offset"] as? Int,
            returned: map["returned"] as? Int,
            total: map["total"] as? Int
        )
    }
}
