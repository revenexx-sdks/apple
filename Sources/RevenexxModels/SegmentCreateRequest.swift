import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class SegmentCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case position = "position"
        case rule_match = "rule_match"
        case rules = "rules"
    }

    /// Stable identifier, unique per tenant — what other apps and integrations name the segment by. Free text, but lowercase with underscores is the convention every seeded vocabulary follows.
    public let code: String
    /// Localized display names keyed by language tag. Null means nobody translated it and a client falls back to showing the code.
    public let labels: [String: AnyCodable]?
    /// Sort order in the cockpit, ascending. Ties fall back to insertion order. Default 0.
    public let position: Int?
    /// How the conditions combine: 'all' (default) is AND, 'any' is OR. Null means the same as 'all'.
    public let rule_match: RevenexxEnums.SegmentRuleMatch?
    /// The selector that decides membership, stored verbatim. Null means the segment is manual-only. The same rule language product categories use, evaluated over organization columns, `setting:<key>` entries and the organization_metrics projection — so 'no order in 365 days' is expressible without joining the orders app. Null makes the segment manual-only. Changing it does not move a single membership — run the recompute.
    public let rules: SegmentRules?

    init(
        code: String,
        labels: [String: AnyCodable]?,
        position: Int?,
        rule_match: RevenexxEnums.SegmentRuleMatch?,
        rules: SegmentRules?
    ) {
        self.code = code
        self.labels = labels
        self.position = position
        self.rule_match = rule_match
        self.rules = rules
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let rule_matchString = try container.decodeIfPresent(String.self, forKey: .rule_match) {
            self.rule_match = RevenexxEnums.SegmentRuleMatch(rawValue: rule_matchString)
        } else {
            self.rule_match = nil
        }
        self.rules = try container.decodeIfPresent(SegmentRules.self, forKey: .rules)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rule_match?.rawValue, forKey: .rule_match)
        try container.encodeIfPresent(rules, forKey: .rules)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "labels": labels as Any,
            "position": position as Any,
            "rule_match": rule_match?.rawValue as Any,
            "rules": rules?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentCreateRequest {
        return SegmentCreateRequest(
            code: map["code"] as! String,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int,
            rule_match: map["rule_match"] as? String != nil ? SegmentRuleMatch(rawValue: map["rule_match"] as! String) : nil,
            rules: SegmentRules.from(map: map["rules"] as! [String: Any])
        )
    }
}
