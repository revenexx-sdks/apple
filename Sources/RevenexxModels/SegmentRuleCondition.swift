import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class SegmentRuleCondition: Codable {

    enum CodingKeys: String, CodingKey {
        case field = "field"
        case `operator` = "operator"
        case value = "value"
    }

    /// What the organization IS: an organizations column (name, status, vat_id, branche, external_team_id) or 'setting:<key>' for a top-level key of organizations.settings. Or what it DID, read from the organization_metrics projection: order_count, order_count_30d/90d/365d, revenue_total, revenue_30d/90d/365d, avg_order_value, avg_order_value_365d, first_order_at, last_order_at, currency — plus the virtual days_since_last_order (gt/gte/lt/lte only), which compares last_order_at against a cut-off computed at evaluation time and never matches an organization that never ordered (use last_order_at is_empty for those).
    public let field: String
    /// How `value` is compared to `field`. `contains`/`starts_with`/`ends_with` are text matches; `in` takes an array; `is_empty`/`is_not_empty` take no value at all.
    public let `operator`: RevenexxEnums.SegmentRuleOperator
    /// Omitted for is_empty/is_not_empty; an array for 'in'; a string, number or boolean otherwise. A number or boolean makes a 'setting:' condition compare as JSONB, so it only matches values stored as a JSON number/boolean.
    public let value: String?

    init(
        field: String,
        `operator`: RevenexxEnums.SegmentRuleOperator,
        value: String?
    ) {
        self.field = field
        self.`operator` = `operator`
        self.value = value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.field = try container.decode(String.self, forKey: .field)
        self.`operator` = RevenexxEnums.SegmentRuleOperator(rawValue: try container.decode(String.self, forKey: .`operator`))!
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(field, forKey: .field)
        try container.encode(`operator`.rawValue, forKey: .`operator`)
        try container.encodeIfPresent(value, forKey: .value)
    }

    public func toMap() -> [String: Any] {
        return [
            "field": field as Any,
            "operator": `operator`.rawValue as Any,
            "value": value as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentRuleCondition {
        return SegmentRuleCondition(
            field: map["field"] as! String,
            operator: SegmentRuleOperator(rawValue: map["operator"] as! String)!,
            value: map["value"] as? String
        )
    }
}
