import Foundation
import JSONCodable

/// 
open class OrderCustomerRollupResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case as_of = "as_of"
        case cursor = "cursor"
        case done = "done"
        case items = "items"
        case orders_scanned = "orders_scanned"
        case orders_without_organization = "orders_without_organization"
        case organizations = "organizations"
        case statuses = "statuses"
        case windows = "windows"
    }

    /// The anchor the windows were measured from — echoed so a paging caller can pin it.
    public let as_of: String?
    /// Where to resume, when `done` is false — the id of the last order this call read. Null once the scan finished. Send it back unchanged, together with the same as_of.
    public let cursor: String?
    /// True = the whole set was scanned and this answer is complete. False = the scan hit its time budget: send `cursor` back to continue, and MERGE the parts (every number is additive, min for first_order_at, max for last_order_at, union for currencies).
    public let done: Bool?
    /// One row per organization that appeared on a counted order, sorted by id. A company with no counted order is absent — this answer does not carry zero rows.
    public let items: [OrderCustomerRollup]?
    /// How many order rows this call read, attributed or not. It is the cost of the call, and on a partial answer the size of the part.
    public let orders_scanned: Int?
    /// Orders read that carry no organization_id — private and guest orders. They are real revenue and are deliberately not attributed to anybody, so they appear here and in no row of items.
    public let orders_without_organization: Int?
    /// How many rows `items` carries. On a partial answer this counts what THIS part saw, not the whole tenant.
    public let organizations: Int?
    /// The statuses that were counted, echoed — the default set unless the request named its own.
    public let statuses: [String]?
    /// The rolling windows the *_30d / *_90d / *_365d numbers were measured over, in days. Echoed so a caller reads the numbers with the right labels instead of hard-coding three of them.
    public let windows: [Int]?

    init(
        as_of: String?,
        cursor: String?,
        done: Bool?,
        items: [OrderCustomerRollup]?,
        orders_scanned: Int?,
        orders_without_organization: Int?,
        organizations: Int?,
        statuses: [String]?,
        windows: [Int]?
    ) {
        self.as_of = as_of
        self.cursor = cursor
        self.done = done
        self.items = items
        self.orders_scanned = orders_scanned
        self.orders_without_organization = orders_without_organization
        self.organizations = organizations
        self.statuses = statuses
        self.windows = windows
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.as_of = try container.decodeIfPresent(String.self, forKey: .as_of)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.done = try container.decodeIfPresent(Bool.self, forKey: .done)
        self.items = try container.decodeIfPresent([OrderCustomerRollup].self, forKey: .items)
        self.orders_scanned = try container.decodeIfPresent(Int.self, forKey: .orders_scanned)
        self.orders_without_organization = try container.decodeIfPresent(Int.self, forKey: .orders_without_organization)
        self.organizations = try container.decodeIfPresent(Int.self, forKey: .organizations)
        self.statuses = try container.decodeIfPresent([String].self, forKey: .statuses)
        self.windows = try container.decodeIfPresent([Int].self, forKey: .windows)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(as_of, forKey: .as_of)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(done, forKey: .done)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(orders_scanned, forKey: .orders_scanned)
        try container.encodeIfPresent(orders_without_organization, forKey: .orders_without_organization)
        try container.encodeIfPresent(organizations, forKey: .organizations)
        try container.encodeIfPresent(statuses, forKey: .statuses)
        try container.encodeIfPresent(windows, forKey: .windows)
    }

    public func toMap() -> [String: Any] {
        return [
            "as_of": as_of as Any,
            "cursor": cursor as Any,
            "done": done as Any,
            "items": items?.map { $0.toMap() } as Any,
            "orders_scanned": orders_scanned as Any,
            "orders_without_organization": orders_without_organization as Any,
            "organizations": organizations as Any,
            "statuses": statuses as Any,
            "windows": windows as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCustomerRollupResponse {
        return OrderCustomerRollupResponse(
            as_of: map["as_of"] as? String,
            cursor: map["cursor"] as? String,
            done: map["done"] as? Bool,
            items: (map["items"] as? [[String: Any]] ?? []).map { OrderCustomerRollup.from(map: $0) },
            orders_scanned: map["orders_scanned"] as? Int,
            orders_without_organization: map["orders_without_organization"] as? Int,
            organizations: map["organizations"] as? Int,
            statuses: map["statuses"] as? [String],
            windows: map["windows"] as? [Int]
        )
    }
}
