import Foundation
import JSONCodable

/// 
open class OrganizationMetricsRefreshResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case as_of = "as_of"
        case batched = "batched"
        case batches = "batches"
        case cursor = "cursor"
        case done = "done"
        case inserted = "inserted"
        case orders_scanned = "orders_scanned"
        case orders_without_organization = "orders_without_organization"
        case organizations = "organizations"
        case unchanged = "unchanged"
        case updated = "updated"
        case with_orders = "with_orders"
    }

    /// The instant the rolling windows are measured from. Send it back on every continuation — that is what stops the 30/90/365-day windows sliding while a multi-call refresh runs.
    public let as_of: String?
    /// False if an insert had to fall back to row-at-a-time. A performance fact, not an error.
    public let batched: Bool?
    /// Rollup calls made to the orders app — the cross-app cost of this pass.
    public let batches: Int?
    /// Where to resume: the id of the last organization this call processed. Send it back verbatim; null when the pass finished. No example is published — the value names a row in THIS tenant, and `cursor: "sample cursor"` reaches PostgREST as a malformed uuid and comes back as a 400 nobody can read.
    public let cursor: String?
    /// False means the budget ran out with work left — POST again with the returned `cursor` AND `as_of`.
    public let done: Bool?
    /// Metrics rows created — organizations that had none yet.
    public let inserted: Int?
    /// Orders the orders app counted while answering this call.
    public let orders_scanned: Int?
    /// Orders the orders app could not attribute to a company (B2C/guest). They belong to no organization and land in no metrics row.
    public let orders_without_organization: Int?
    /// Organizations processed by THIS call.
    public let organizations: Int?
    /// Rows that already said the same thing — no write was issued. A routine refresh is almost all of these.
    public let unchanged: Int?
    /// Metrics rows whose numbers actually changed.
    public let updated: Int?
    /// Of those, how many have at least one counted order.
    public let with_orders: Int?

    init(
        as_of: String?,
        batched: Bool?,
        batches: Int?,
        cursor: String?,
        done: Bool?,
        inserted: Int?,
        orders_scanned: Int?,
        orders_without_organization: Int?,
        organizations: Int?,
        unchanged: Int?,
        updated: Int?,
        with_orders: Int?
    ) {
        self.as_of = as_of
        self.batched = batched
        self.batches = batches
        self.cursor = cursor
        self.done = done
        self.inserted = inserted
        self.orders_scanned = orders_scanned
        self.orders_without_organization = orders_without_organization
        self.organizations = organizations
        self.unchanged = unchanged
        self.updated = updated
        self.with_orders = with_orders
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.as_of = try container.decodeIfPresent(String.self, forKey: .as_of)
        self.batched = try container.decodeIfPresent(Bool.self, forKey: .batched)
        self.batches = try container.decodeIfPresent(Int.self, forKey: .batches)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.done = try container.decodeIfPresent(Bool.self, forKey: .done)
        self.inserted = try container.decodeIfPresent(Int.self, forKey: .inserted)
        self.orders_scanned = try container.decodeIfPresent(Int.self, forKey: .orders_scanned)
        self.orders_without_organization = try container.decodeIfPresent(Int.self, forKey: .orders_without_organization)
        self.organizations = try container.decodeIfPresent(Int.self, forKey: .organizations)
        self.unchanged = try container.decodeIfPresent(Int.self, forKey: .unchanged)
        self.updated = try container.decodeIfPresent(Int.self, forKey: .updated)
        self.with_orders = try container.decodeIfPresent(Int.self, forKey: .with_orders)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(as_of, forKey: .as_of)
        try container.encodeIfPresent(batched, forKey: .batched)
        try container.encodeIfPresent(batches, forKey: .batches)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(done, forKey: .done)
        try container.encodeIfPresent(inserted, forKey: .inserted)
        try container.encodeIfPresent(orders_scanned, forKey: .orders_scanned)
        try container.encodeIfPresent(orders_without_organization, forKey: .orders_without_organization)
        try container.encodeIfPresent(organizations, forKey: .organizations)
        try container.encodeIfPresent(unchanged, forKey: .unchanged)
        try container.encodeIfPresent(updated, forKey: .updated)
        try container.encodeIfPresent(with_orders, forKey: .with_orders)
    }

    public func toMap() -> [String: Any] {
        return [
            "as_of": as_of as Any,
            "batched": batched as Any,
            "batches": batches as Any,
            "cursor": cursor as Any,
            "done": done as Any,
            "inserted": inserted as Any,
            "orders_scanned": orders_scanned as Any,
            "orders_without_organization": orders_without_organization as Any,
            "organizations": organizations as Any,
            "unchanged": unchanged as Any,
            "updated": updated as Any,
            "with_orders": with_orders as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrganizationMetricsRefreshResponse {
        return OrganizationMetricsRefreshResponse(
            as_of: map["as_of"] as? String,
            batched: map["batched"] as? Bool,
            batches: map["batches"] as? Int,
            cursor: map["cursor"] as? String,
            done: map["done"] as? Bool,
            inserted: map["inserted"] as? Int,
            orders_scanned: map["orders_scanned"] as? Int,
            orders_without_organization: map["orders_without_organization"] as? Int,
            organizations: map["organizations"] as? Int,
            unchanged: map["unchanged"] as? Int,
            updated: map["updated"] as? Int,
            with_orders: map["with_orders"] as? Int
        )
    }
}
