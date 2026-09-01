import Foundation
import JSONCodable

/// Aggregate orders per organization. Send organization_ids to answer for a known batch; omit them to scan every attributable order. Both forms are paged and time-budgeted the same way — read `done` before treating any answer as complete.
open class OrderCustomerRollupRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case as_of = "as_of"
        case cursor = "cursor"
        case organization_ids = "organization_ids"
        case statuses = "statuses"
    }

    /// Anchor for the rolling windows (default now). Pin it and send it back on every call of a loop, otherwise the windows drift by the duration of the loop.
    public let as_of: String?
    /// Continue an unfinished scan: the exact value the previous call returned, which is the id of the last order it read. Do not construct one — it is a resume point, not an offset. Omit it on the first call. It is honoured in BOTH call shapes, organization_ids included: send the whole batch again alongside it whenever `done` came back false, or the part of the batch after the cursor is simply never read.
    public let cursor: String?
    /// Roll up exactly these organizations and no others — at most 200, because the ids travel to the data plane as one in.() filter. Naming them does NOT make the answer complete by itself: the scan is the same paged, time-budgeted loop either way, so a batch with more orders than one page can still stop early with `done: false` and a cursor. Small batches finish in one call, which is the normal case, but check `done` rather than assume it. Omitted = scan every order and answer for every organization that appears on one.
    public let organization_ids: [String]?
    /// Which lifecycle statuses count as revenue. Defaults to placed, in_fulfillment and completed: a pending order was never placed, and a cancelled one is not revenue. Widening this is how a merchant who books on approval gets their own definition of the same numbers.
    public let statuses: [String]?

    init(
        as_of: String?,
        cursor: String?,
        organization_ids: [String]?,
        statuses: [String]?
    ) {
        self.as_of = as_of
        self.cursor = cursor
        self.organization_ids = organization_ids
        self.statuses = statuses
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.as_of = try container.decodeIfPresent(String.self, forKey: .as_of)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.organization_ids = try container.decodeIfPresent([String].self, forKey: .organization_ids)
        self.statuses = try container.decodeIfPresent([String].self, forKey: .statuses)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(as_of, forKey: .as_of)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(organization_ids, forKey: .organization_ids)
        try container.encodeIfPresent(statuses, forKey: .statuses)
    }

    public func toMap() -> [String: Any] {
        return [
            "as_of": as_of as Any,
            "cursor": cursor as Any,
            "organization_ids": organization_ids as Any,
            "statuses": statuses as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCustomerRollupRequest {
        return OrderCustomerRollupRequest(
            as_of: map["as_of"] as? String,
            cursor: map["cursor"] as? String,
            organization_ids: map["organization_ids"] as? [String],
            statuses: map["statuses"] as? [String]
        )
    }
}
