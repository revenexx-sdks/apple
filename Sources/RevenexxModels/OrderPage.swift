import Foundation
import JSONCodable

/// Where this answer sits in the whole result set.
open class OrderPage: Codable {

    enum CodingKeys: String, CodingKey {
        case hasMore = "hasMore"
        case limit = "limit"
        case offset = "offset"
        case returned = "returned"
        case total = "total"
    }

    /// Whether another page exists after this one (offset + returned < total). The one field a "load more" button should read.
    public let hasMore: Bool?
    /// The page size that was applied. A requested limit above 200 is CLAMPED to 200 rather than refused, so this is the number to believe, not the one you sent.
    public let limit: Int?
    /// The row offset that was applied.
    public let offset: Int?
    /// How many rows are in `items` right here — less than `limit` on the last page.
    public let returned: Int?
    /// How many rows match the filter in total, ignoring limit and offset. This is what a page count is computed from.
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

    public static func from(map: [String: Any] ) -> OrderPage {
        return OrderPage(
            hasMore: map["hasMore"] as? Bool,
            limit: map["limit"] as? Int,
            offset: map["offset"] as? Int,
            returned: map["returned"] as? Int,
            total: map["total"] as? Int
        )
    }
}
