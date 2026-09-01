import Foundation
import JSONCodable

/// What an organization has BOUGHT, materialized from the orders app. One row per organization — including all-zero rows for companies that never ordered, so a 'never bought anything' rule has something to match.
open class OrganizationMetrics: Codable {

    enum CodingKeys: String, CodingKey {
        case avg_order_value = "avg_order_value"
        case avg_order_value_365d = "avg_order_value_365d"
        case computed_at = "computed_at"
        case created_at = "created_at"
        case currency = "currency"
        case currency_mixed = "currency_mixed"
        case first_order_at = "first_order_at"
        case id = "id"
        case last_order_at = "last_order_at"
        case order_count = "order_count"
        case order_count_30d = "order_count_30d"
        case order_count_365d = "order_count_365d"
        case order_count_90d = "order_count_90d"
        case orders_as_of = "orders_as_of"
        case organization_id = "organization_id"
        case revenue_30d = "revenue_30d"
        case revenue_365d = "revenue_365d"
        case revenue_90d = "revenue_90d"
        case revenue_total = "revenue_total"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// revenue_total / order_count, computed here from the sums rather than averaged upstream. Zero when there are no orders.
    public let avg_order_value: Double?
    /// revenue_365d / order_count_365d. Zero when there were none in the window.
    public let avg_order_value_365d: Double?
    /// When this row was last written. The projection is materialized, so this is how stale the numbers are.
    public let computed_at: String?
    /// When the projection row first appeared.
    public let created_at: String?
    /// The single ISO 4217 currency all counted orders were in. NULL when there were none, and also when there were several — read `currency_mixed` to tell those two apart.
    public let currency: String?
    /// True when this company ordered in more than one currency. The sums are still stored (dropping money is worse), but they are not comparable against a threshold, and a rule reading revenue should say so.
    public let currency_mixed: Bool?
    /// When this company first ordered. Null if it never has — that is what makes it usable as "is this a customer at all?".
    public let first_order_at: String?
    /// Primary key of the projection row.
    public let id: String?
    /// When this company last ordered. Null if it never has, which is why the virtual `days_since_last_order` rule field never matches those companies: use `last_order_at is_empty` for them.
    public let last_order_at: String?
    /// Orders ever counted for this company.
    public let order_count: Int?
    /// Orders in the 30 days before `orders_as_of`. A rolling window, not a calendar month.
    public let order_count_30d: Int?
    /// Orders in the 365 days before `orders_as_of`.
    public let order_count_365d: Int?
    /// Orders in the 90 days before `orders_as_of`.
    public let order_count_90d: Int?
    /// The instant the rolling windows were measured from. Pinned across a chunked refresh, so a multi-call pass cannot let the windows slide underneath it.
    public let orders_as_of: String?
    /// The company these numbers describe. One row per organization, and rows exist for companies that never ordered — all zeros rather than missing, so a "never bought" rule matches something.
    public let organization_id: String?
    /// Revenue in the 30 days before `orders_as_of`.
    public let revenue_30d: Double?
    /// Revenue in the 365 days before `orders_as_of`. The usual "how big is this customer" number, and the one a key-account rule should read.
    public let revenue_365d: Double?
    /// Revenue in the 90 days before `orders_as_of`.
    public let revenue_90d: Double?
    /// Revenue ever counted, in `currency`. Which orders count is the orders app's decision, not this app's.
    public let revenue_total: Double?
    /// The tenant this row belongs to — the store slug, not an id. Set by the platform from the authenticated context, never by a caller; a write that carries it is ignored, and no request can read another tenant's rows by sending a different one.
    public let tenant_id: String?
    /// When the row last changed. Unchanged numbers are not rewritten, so this can lag `computed_at`.
    public let updated_at: String?

    init(
        avg_order_value: Double?,
        avg_order_value_365d: Double?,
        computed_at: String?,
        created_at: String?,
        currency: String?,
        currency_mixed: Bool?,
        first_order_at: String?,
        id: String?,
        last_order_at: String?,
        order_count: Int?,
        order_count_30d: Int?,
        order_count_365d: Int?,
        order_count_90d: Int?,
        orders_as_of: String?,
        organization_id: String?,
        revenue_30d: Double?,
        revenue_365d: Double?,
        revenue_90d: Double?,
        revenue_total: Double?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.avg_order_value = avg_order_value
        self.avg_order_value_365d = avg_order_value_365d
        self.computed_at = computed_at
        self.created_at = created_at
        self.currency = currency
        self.currency_mixed = currency_mixed
        self.first_order_at = first_order_at
        self.id = id
        self.last_order_at = last_order_at
        self.order_count = order_count
        self.order_count_30d = order_count_30d
        self.order_count_365d = order_count_365d
        self.order_count_90d = order_count_90d
        self.orders_as_of = orders_as_of
        self.organization_id = organization_id
        self.revenue_30d = revenue_30d
        self.revenue_365d = revenue_365d
        self.revenue_90d = revenue_90d
        self.revenue_total = revenue_total
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.avg_order_value = try container.decodeIfPresent(Double.self, forKey: .avg_order_value)
        self.avg_order_value_365d = try container.decodeIfPresent(Double.self, forKey: .avg_order_value_365d)
        self.computed_at = try container.decodeIfPresent(String.self, forKey: .computed_at)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.currency_mixed = try container.decodeIfPresent(Bool.self, forKey: .currency_mixed)
        self.first_order_at = try container.decodeIfPresent(String.self, forKey: .first_order_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.last_order_at = try container.decodeIfPresent(String.self, forKey: .last_order_at)
        self.order_count = try container.decodeIfPresent(Int.self, forKey: .order_count)
        self.order_count_30d = try container.decodeIfPresent(Int.self, forKey: .order_count_30d)
        self.order_count_365d = try container.decodeIfPresent(Int.self, forKey: .order_count_365d)
        self.order_count_90d = try container.decodeIfPresent(Int.self, forKey: .order_count_90d)
        self.orders_as_of = try container.decodeIfPresent(String.self, forKey: .orders_as_of)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.revenue_30d = try container.decodeIfPresent(Double.self, forKey: .revenue_30d)
        self.revenue_365d = try container.decodeIfPresent(Double.self, forKey: .revenue_365d)
        self.revenue_90d = try container.decodeIfPresent(Double.self, forKey: .revenue_90d)
        self.revenue_total = try container.decodeIfPresent(Double.self, forKey: .revenue_total)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(avg_order_value, forKey: .avg_order_value)
        try container.encodeIfPresent(avg_order_value_365d, forKey: .avg_order_value_365d)
        try container.encodeIfPresent(computed_at, forKey: .computed_at)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(currency_mixed, forKey: .currency_mixed)
        try container.encodeIfPresent(first_order_at, forKey: .first_order_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(last_order_at, forKey: .last_order_at)
        try container.encodeIfPresent(order_count, forKey: .order_count)
        try container.encodeIfPresent(order_count_30d, forKey: .order_count_30d)
        try container.encodeIfPresent(order_count_365d, forKey: .order_count_365d)
        try container.encodeIfPresent(order_count_90d, forKey: .order_count_90d)
        try container.encodeIfPresent(orders_as_of, forKey: .orders_as_of)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(revenue_30d, forKey: .revenue_30d)
        try container.encodeIfPresent(revenue_365d, forKey: .revenue_365d)
        try container.encodeIfPresent(revenue_90d, forKey: .revenue_90d)
        try container.encodeIfPresent(revenue_total, forKey: .revenue_total)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "avg_order_value": avg_order_value as Any,
            "avg_order_value_365d": avg_order_value_365d as Any,
            "computed_at": computed_at as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "currency_mixed": currency_mixed as Any,
            "first_order_at": first_order_at as Any,
            "id": id as Any,
            "last_order_at": last_order_at as Any,
            "order_count": order_count as Any,
            "order_count_30d": order_count_30d as Any,
            "order_count_365d": order_count_365d as Any,
            "order_count_90d": order_count_90d as Any,
            "orders_as_of": orders_as_of as Any,
            "organization_id": organization_id as Any,
            "revenue_30d": revenue_30d as Any,
            "revenue_365d": revenue_365d as Any,
            "revenue_90d": revenue_90d as Any,
            "revenue_total": revenue_total as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrganizationMetrics {
        return OrganizationMetrics(
            avg_order_value: map["avg_order_value"] as? Double,
            avg_order_value_365d: map["avg_order_value_365d"] as? Double,
            computed_at: map["computed_at"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            currency_mixed: map["currency_mixed"] as? Bool,
            first_order_at: map["first_order_at"] as? String,
            id: map["id"] as? String,
            last_order_at: map["last_order_at"] as? String,
            order_count: map["order_count"] as? Int,
            order_count_30d: map["order_count_30d"] as? Int,
            order_count_365d: map["order_count_365d"] as? Int,
            order_count_90d: map["order_count_90d"] as? Int,
            orders_as_of: map["orders_as_of"] as? String,
            organization_id: map["organization_id"] as? String,
            revenue_30d: map["revenue_30d"] as? Double,
            revenue_365d: map["revenue_365d"] as? Double,
            revenue_90d: map["revenue_90d"] as? Double,
            revenue_total: map["revenue_total"] as? Double,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
