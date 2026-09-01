import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class CategoriesCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case parent_id = "parent_id"
        case path = "path"
        case position = "position"
        case rule_match = "rule_match"
        case rules = "rules"
        case rules_computed_at = "rules_computed_at"
        case values = "values"
    }

    /// The category's stable identifier — what an import and a storefront join on, and what survives a rename of the label. Unique per tenant.
    public let code: String
    /// The category name a person sees, per language tag. The catalog reads by name, not by code — a locale left blank falls back to the next filled one.
    public let labels: [String: AnyCodable]?
    /// The category this one hangs under. Null is a root of the tree. Deleting a parent lifts its children to the root rather than deleting them, so a mis-click never takes a subtree with it.
    public let parent_id: String?
    /// A materialized position in the tree, kept for importers that carry one (`tools/power_tools/cordless_drills`). Nothing in this app writes or reads it — `parent_id` is the structure this app navigates.
    public let path: String?
    /// Order among the siblings under the same parent, ascending.
    public let position: Int?
    /// How the conditions combine: 'all' ANDs them (the default), 'any' ORs them. It is a column of its own rather than a key of `rules` because the compiler reads the two separately.
    public let rule_match: RevenexxEnums.CategoriesRuleMatch?
    /// The selector that makes this a RULE-DRIVEN category. Null means hand-picked. Matching products are MATERIALIZED as `product_categories` rows with source `rule`, next to the hand-picked ones a recompute never touches; `POST /products/categories/{category_id}/rules/preview` dry-runs this exact document before it is stored. Conditions address the `common` bucket of a product's values — a value held per locale or per channel has no single answer for a rule to test.
    public let rules: [String: AnyCodable]?
    /// When the rule last ran TO COMPLETION and its memberships were synced. Null means no pass has ever finished — a recompute is chunked, so a half-finished pass leaves this untouched.
    public let rules_computed_at: String?
    /// Whatever this catalog keeps on a category beyond the model — the keys belong to the tenant, not to this app, and nothing here reads them.
    public let values: [String: AnyCodable]?

    init(
        code: String,
        labels: [String: AnyCodable]?,
        parent_id: String?,
        path: String?,
        position: Int?,
        rule_match: RevenexxEnums.CategoriesRuleMatch?,
        rules: [String: AnyCodable]?,
        rules_computed_at: String?,
        values: [String: AnyCodable]?
    ) {
        self.code = code
        self.labels = labels
        self.parent_id = parent_id
        self.path = path
        self.position = position
        self.rule_match = rule_match
        self.rules = rules
        self.rules_computed_at = rules_computed_at
        self.values = values
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.parent_id = try container.decodeIfPresent(String.self, forKey: .parent_id)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let rule_matchString = try container.decodeIfPresent(String.self, forKey: .rule_match) {
            self.rule_match = RevenexxEnums.CategoriesRuleMatch(rawValue: rule_matchString)
        } else {
            self.rule_match = nil
        }
        self.rules = try container.decodeIfPresent([String: AnyCodable].self, forKey: .rules)
        self.rules_computed_at = try container.decodeIfPresent(String.self, forKey: .rules_computed_at)
        self.values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(parent_id, forKey: .parent_id)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rule_match?.rawValue, forKey: .rule_match)
        try container.encodeIfPresent(rules, forKey: .rules)
        try container.encodeIfPresent(rules_computed_at, forKey: .rules_computed_at)
        try container.encodeIfPresent(values, forKey: .values)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "labels": labels as Any,
            "parent_id": parent_id as Any,
            "path": path as Any,
            "position": position as Any,
            "rule_match": rule_match?.rawValue as Any,
            "rules": rules as Any,
            "rules_computed_at": rules_computed_at as Any,
            "values": values as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CategoriesCreateRequest {
        return CategoriesCreateRequest(
            code: map["code"] as! String,
            labels: map["labels"] as? [String: AnyCodable],
            parent_id: map["parent_id"] as? String,
            path: map["path"] as? String,
            position: map["position"] as? Int,
            rule_match: map["rule_match"] as? String != nil ? CategoriesRuleMatch(rawValue: map["rule_match"] as! String) : nil,
            rules: map["rules"] as? [String: AnyCodable],
            rules_computed_at: map["rules_computed_at"] as? String,
            values: map["values"] as? [String: AnyCodable]
        )
    }
}
