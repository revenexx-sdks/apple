import Foundation
import JSONCodable
import RevenexxEnums

/// The selector that decides membership, stored verbatim. Null means the segment is manual-only. The same rule language product categories use, evaluated over organization columns, `setting:<key>` entries and the organization_metrics projection — so 'no order in 365 days' is expressible without joining the orders app. Null makes the segment manual-only. Changing it does not move a single membership — run the recompute.
open class SegmentRules: Codable {

    enum CodingKeys: String, CodingKey {
        case conditions = "conditions"
        case target = "target"
    }

    /// The conditions, combined by `rule_match`. At least one, at most 25.
    public let conditions: [SegmentRuleCondition]
    /// Only 'organizations' is supported; any other value is rejected. A segment groups COMPANIES — the people are reached through them.
    public let target: RevenexxEnums.SegmentRulesTarget?

    init(
        conditions: [SegmentRuleCondition],
        target: RevenexxEnums.SegmentRulesTarget?
    ) {
        self.conditions = conditions
        self.target = target
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.conditions = try container.decode([SegmentRuleCondition].self, forKey: .conditions)
        if let targetString = try container.decodeIfPresent(String.self, forKey: .target) {
            self.target = RevenexxEnums.SegmentRulesTarget(rawValue: targetString)
        } else {
            self.target = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(conditions, forKey: .conditions)
        try container.encodeIfPresent(target?.rawValue, forKey: .target)
    }

    public func toMap() -> [String: Any] {
        return [
            "conditions": conditions.map { $0.toMap() } as Any,
            "target": target?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentRules {
        return SegmentRules(
            conditions: (map["conditions"] as! [[String: Any]]).map { SegmentRuleCondition.from(map: $0) },
            target: map["target"] as? String != nil ? SegmentRulesTarget(rawValue: map["target"] as! String) : nil
        )
    }
}
