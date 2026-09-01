import Foundation
import JSONCodable
import RevenexxEnums

/// A named group of ORGANIZATIONS — by hand, by rule, or both at once.
open class Segment: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case labels = "labels"
        case position = "position"
        case rule_match = "rule_match"
        case rules = "rules"
        case rules_computed_at = "rules_computed_at"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// Stable identifier, unique per tenant — what other apps and integrations name the segment by. Free text, but lowercase with underscores is the convention every seeded vocabulary follows.
    public let code: String?
    /// When the segment was created.
    public let created_at: String?
    /// Primary key of the segment.
    public let id: String?
    /// Localized display names keyed by language tag. Null means nobody translated it and a client falls back to showing the code.
    public let labels: [String: AnyCodable]?
    /// Sort order in the cockpit, ascending. Ties fall back to insertion order.
    public let position: Int?
    /// How the conditions combine: 'all' (default) is AND, 'any' is OR. Null means the same as 'all'.
    public let rule_match: RevenexxEnums.SegmentRuleMatch?
    /// The selector that decides membership, stored verbatim. Null means the segment is manual-only. The same rule language product categories use, evaluated over organization columns, `setting:<key>` entries and the organization_metrics projection — so 'no order in 365 days' is expressible without joining the orders app.
    public let rules: [String: AnyCodable]?
    /// When the rule last finished a COMPLETE recompute. Null after a rule change, and while a chunked recompute is still running — so it doubles as "are the rule memberships trustworthy right now?".
    public let rules_computed_at: String?
    /// The tenant this row belongs to — the store slug, not an id. Set by the platform from the authenticated context, never by a caller; a write that carries it is ignored, and no request can read another tenant's rows by sending a different one.
    public let tenant_id: String?
    /// When any column of this row last changed.
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        labels: [String: AnyCodable]?,
        position: Int?,
        rule_match: RevenexxEnums.SegmentRuleMatch?,
        rules: [String: AnyCodable]?,
        rules_computed_at: String?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.labels = labels
        self.position = position
        self.rule_match = rule_match
        self.rules = rules
        self.rules_computed_at = rules_computed_at
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let rule_matchString = try container.decodeIfPresent(String.self, forKey: .rule_match) {
            self.rule_match = RevenexxEnums.SegmentRuleMatch(rawValue: rule_matchString)
        } else {
            self.rule_match = nil
        }
        self.rules = try container.decodeIfPresent([String: AnyCodable].self, forKey: .rules)
        self.rules_computed_at = try container.decodeIfPresent(String.self, forKey: .rules_computed_at)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rule_match?.rawValue, forKey: .rule_match)
        try container.encodeIfPresent(rules, forKey: .rules)
        try container.encodeIfPresent(rules_computed_at, forKey: .rules_computed_at)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "labels": labels as Any,
            "position": position as Any,
            "rule_match": rule_match?.rawValue as Any,
            "rules": rules as Any,
            "rules_computed_at": rules_computed_at as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Segment {
        return Segment(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            rule_match: map["rule_match"] as? String != nil ? SegmentRuleMatch(rawValue: map["rule_match"] as! String) : nil,
            rules: map["rules"] as? [String: AnyCodable],
            rules_computed_at: map["rules_computed_at"] as? String,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
