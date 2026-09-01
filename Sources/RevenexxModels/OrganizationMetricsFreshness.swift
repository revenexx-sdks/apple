import Foundation
import JSONCodable

/// 
open class OrganizationMetricsFreshness: Codable {

    enum CodingKeys: String, CodingKey {
        case missing = "missing"
        case oldest_computed_at = "oldest_computed_at"
        case orders_as_of = "orders_as_of"
        case organizations = "organizations"
        case rows = "rows"
    }

    /// Companies with no metrics row yet. A rule reading revenue silently skips them, so this is the number to watch after an import.
    public let missing: Int?
    /// The OLDEST computed_at in the table — the floor, not an average. Null when there are no rows at all.
    public let oldest_computed_at: String?
    /// The anchor those oldest numbers were measured from.
    public let orders_as_of: String?
    /// Companies in this tenant.
    public let organizations: Int?
    /// Metrics rows that exist — at most one per company.
    public let rows: Int?

    init(
        missing: Int?,
        oldest_computed_at: String?,
        orders_as_of: String?,
        organizations: Int?,
        rows: Int?
    ) {
        self.missing = missing
        self.oldest_computed_at = oldest_computed_at
        self.orders_as_of = orders_as_of
        self.organizations = organizations
        self.rows = rows
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.missing = try container.decodeIfPresent(Int.self, forKey: .missing)
        self.oldest_computed_at = try container.decodeIfPresent(String.self, forKey: .oldest_computed_at)
        self.orders_as_of = try container.decodeIfPresent(String.self, forKey: .orders_as_of)
        self.organizations = try container.decodeIfPresent(Int.self, forKey: .organizations)
        self.rows = try container.decodeIfPresent(Int.self, forKey: .rows)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(missing, forKey: .missing)
        try container.encodeIfPresent(oldest_computed_at, forKey: .oldest_computed_at)
        try container.encodeIfPresent(orders_as_of, forKey: .orders_as_of)
        try container.encodeIfPresent(organizations, forKey: .organizations)
        try container.encodeIfPresent(rows, forKey: .rows)
    }

    public func toMap() -> [String: Any] {
        return [
            "missing": missing as Any,
            "oldest_computed_at": oldest_computed_at as Any,
            "orders_as_of": orders_as_of as Any,
            "organizations": organizations as Any,
            "rows": rows as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrganizationMetricsFreshness {
        return OrganizationMetricsFreshness(
            missing: map["missing"] as? Int,
            oldest_computed_at: map["oldest_computed_at"] as? String,
            orders_as_of: map["orders_as_of"] as? String,
            organizations: map["organizations"] as? Int,
            rows: map["rows"] as? Int
        )
    }
}
