import Foundation
import JSONCodable

/// Additive order facts for one organization. Average order value is revenue_total / order_count.
open class OrderCustomerRollup: Codable {

    enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
        case first_order_at = "first_order_at"
        case last_order_at = "last_order_at"
        case order_count = "order_count"
        case order_count_30d = "order_count_30d"
        case order_count_365d = "order_count_365d"
        case order_count_90d = "order_count_90d"
        case organization_id = "organization_id"
        case revenue_30d = "revenue_30d"
        case revenue_365d = "revenue_365d"
        case revenue_90d = "revenue_90d"
        case revenue_total = "revenue_total"
    }

    /// Every currency seen on the counted orders, sorted. MORE THAN ONE MEANS THE SUMS MIX CURRENCIES — nothing here converts, so a two-currency row's revenue_total is a sum of unlike numbers and should be shown per currency or not at all.
    public let currencies: [String]?
    /// When this company first ordered — placed_at where there is one, otherwise created_at. Null cannot happen on a row that exists, but the field is nullable because the columns behind it are.
    public let first_order_at: String?
    /// When they last ordered. Together with as_of this is the recency a churn rule reads.
    public let last_order_at: String?
    /// How many orders of this company were counted — orders in one of the counted statuses, over all time.
    public let order_count: Int?
    /// Orders in the 30 days before as_of.
    public let order_count_30d: Int?
    /// Orders in the 365 days before as_of — the rolling year a "still active" rule usually asks about.
    public let order_count_365d: Int?
    /// Orders in the 90 days before as_of.
    public let order_count_90d: Int?
    /// The company these facts belong to — the id the customers app knows it by. Every row of the answer carries one; orders without an organization are counted in orders_without_organization instead.
    public let organization_id: String?
    /// Revenue in the 30 days before as_of.
    public let revenue_30d: Double?
    /// Revenue in the 365 days before as_of.
    public let revenue_365d: Double?
    /// Revenue in the 90 days before as_of.
    public let revenue_90d: Double?
    /// Sum of grand_total over the counted orders. Gross: it includes tax and shipping, because grand_total does.
    public let revenue_total: Double?

    init(
        currencies: [String]?,
        first_order_at: String?,
        last_order_at: String?,
        order_count: Int?,
        order_count_30d: Int?,
        order_count_365d: Int?,
        order_count_90d: Int?,
        organization_id: String?,
        revenue_30d: Double?,
        revenue_365d: Double?,
        revenue_90d: Double?,
        revenue_total: Double?
    ) {
        self.currencies = currencies
        self.first_order_at = first_order_at
        self.last_order_at = last_order_at
        self.order_count = order_count
        self.order_count_30d = order_count_30d
        self.order_count_365d = order_count_365d
        self.order_count_90d = order_count_90d
        self.organization_id = organization_id
        self.revenue_30d = revenue_30d
        self.revenue_365d = revenue_365d
        self.revenue_90d = revenue_90d
        self.revenue_total = revenue_total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currencies = try container.decodeIfPresent([String].self, forKey: .currencies)
        self.first_order_at = try container.decodeIfPresent(String.self, forKey: .first_order_at)
        self.last_order_at = try container.decodeIfPresent(String.self, forKey: .last_order_at)
        self.order_count = try container.decodeIfPresent(Int.self, forKey: .order_count)
        self.order_count_30d = try container.decodeIfPresent(Int.self, forKey: .order_count_30d)
        self.order_count_365d = try container.decodeIfPresent(Int.self, forKey: .order_count_365d)
        self.order_count_90d = try container.decodeIfPresent(Int.self, forKey: .order_count_90d)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.revenue_30d = try container.decodeIfPresent(Double.self, forKey: .revenue_30d)
        self.revenue_365d = try container.decodeIfPresent(Double.self, forKey: .revenue_365d)
        self.revenue_90d = try container.decodeIfPresent(Double.self, forKey: .revenue_90d)
        self.revenue_total = try container.decodeIfPresent(Double.self, forKey: .revenue_total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(first_order_at, forKey: .first_order_at)
        try container.encodeIfPresent(last_order_at, forKey: .last_order_at)
        try container.encodeIfPresent(order_count, forKey: .order_count)
        try container.encodeIfPresent(order_count_30d, forKey: .order_count_30d)
        try container.encodeIfPresent(order_count_365d, forKey: .order_count_365d)
        try container.encodeIfPresent(order_count_90d, forKey: .order_count_90d)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(revenue_30d, forKey: .revenue_30d)
        try container.encodeIfPresent(revenue_365d, forKey: .revenue_365d)
        try container.encodeIfPresent(revenue_90d, forKey: .revenue_90d)
        try container.encodeIfPresent(revenue_total, forKey: .revenue_total)
    }

    public func toMap() -> [String: Any] {
        return [
            "currencies": currencies as Any,
            "first_order_at": first_order_at as Any,
            "last_order_at": last_order_at as Any,
            "order_count": order_count as Any,
            "order_count_30d": order_count_30d as Any,
            "order_count_365d": order_count_365d as Any,
            "order_count_90d": order_count_90d as Any,
            "organization_id": organization_id as Any,
            "revenue_30d": revenue_30d as Any,
            "revenue_365d": revenue_365d as Any,
            "revenue_90d": revenue_90d as Any,
            "revenue_total": revenue_total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderCustomerRollup {
        return OrderCustomerRollup(
            currencies: map["currencies"] as? [String],
            first_order_at: map["first_order_at"] as? String,
            last_order_at: map["last_order_at"] as? String,
            order_count: map["order_count"] as? Int,
            order_count_30d: map["order_count_30d"] as? Int,
            order_count_365d: map["order_count_365d"] as? Int,
            order_count_90d: map["order_count_90d"] as? Int,
            organization_id: map["organization_id"] as? String,
            revenue_30d: map["revenue_30d"] as? Double,
            revenue_365d: map["revenue_365d"] as? Double,
            revenue_90d: map["revenue_90d"] as? Double,
            revenue_total: map["revenue_total"] as? Double
        )
    }
}
