import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class CategoryRuleCondition: Codable {

    enum CodingKeys: String, CodingKey {
        case field = "field"
        case `operator` = "operator"
        case value = "value"
    }

    /// A product column (sku, kind, enabled, family_id, parent_id) or 'attribute:<code>' for the common bucket of attribute_values. An attribute code is [A-Za-z0-9_]+. Locale-/channel-scoped attributes are not supported.
    public let field: String
    /// How to compare. 'eq'/'neq' are equality, 'gt'/'gte'/'lt'/'lte' order (numerically for a number, as text for a string), 'in' membership, 'contains'/'starts_with'/'ends_with' substring, 'is_empty'/'is_not_empty' presence — those last two take no `value`.
    public let `operator`: RevenexxEnums.CategoryRuleOperator
    /// Comparison value. An array for 'in' — non-empty, at most 200 entries, all of the same type; omitted for 'is_empty'/'is_not_empty'; a non-empty string for 'contains'/'starts_with'/'ends_with'; a string or number for gt/gte/lt/lte. Numbers compare numerically (jsonb), strings as text.
    public let value: String?

    init(
        field: String,
        `operator`: RevenexxEnums.CategoryRuleOperator,
        value: String?
    ) {
        self.field = field
        self.`operator` = `operator`
        self.value = value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.field = try container.decode(String.self, forKey: .field)
        self.`operator` = RevenexxEnums.CategoryRuleOperator(rawValue: try container.decode(String.self, forKey: .`operator`))!
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

    public static func from(map: [String: Any] ) -> CategoryRuleCondition {
        return CategoryRuleCondition(
            field: map["field"] as! String,
            operator: CategoryRuleOperator(rawValue: map["operator"] as! String)!,
            value: map["value"] as? String
        )
    }
}
