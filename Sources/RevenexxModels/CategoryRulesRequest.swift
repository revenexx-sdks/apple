import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class CategoryRulesRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case conditions = "conditions"
        case rule_match = "rule_match"
    }

    /// Between 1 and 25 conditions — a rule is a selector, not a query language. An empty list is a 400, not "everything".
    public let conditions: [CategoryRuleCondition]
    /// 'all' ANDs every condition (default), 'any' ORs them.
    public let rule_match: RevenexxEnums.CategoryRuleMatch?

    init(
        conditions: [CategoryRuleCondition],
        rule_match: RevenexxEnums.CategoryRuleMatch?
    ) {
        self.conditions = conditions
        self.rule_match = rule_match
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.conditions = try container.decode([CategoryRuleCondition].self, forKey: .conditions)
        if let rule_matchString = try container.decodeIfPresent(String.self, forKey: .rule_match) {
            self.rule_match = RevenexxEnums.CategoryRuleMatch(rawValue: rule_matchString)
        } else {
            self.rule_match = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(conditions, forKey: .conditions)
        try container.encodeIfPresent(rule_match?.rawValue, forKey: .rule_match)
    }

    public func toMap() -> [String: Any] {
        return [
            "conditions": conditions.map { $0.toMap() } as Any,
            "rule_match": rule_match?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CategoryRulesRequest {
        return CategoryRulesRequest(
            conditions: (map["conditions"] as! [[String: Any]]).map { CategoryRuleCondition.from(map: $0) },
            rule_match: map["rule_match"] as? String != nil ? CategoryRuleMatch(rawValue: map["rule_match"] as! String) : nil
        )
    }
}
