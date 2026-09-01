import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class SegmentRulePreviewRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case conditions = "conditions"
        case rule_match = "rule_match"
        case target = "target"
    }

    /// The conditions, combined by `rule_match`. At least one, at most 25.
    public let conditions: [SegmentRuleCondition]
    /// How the conditions combine. Default 'all'.
    public let rule_match: RevenexxEnums.SegmentRulePreviewRequestRuleMatch?
    /// Only 'organizations' is supported; any other value is rejected. A segment groups COMPANIES — the people are reached through them.
    public let target: RevenexxEnums.SegmentRulePreviewRequestTarget?

    init(
        conditions: [SegmentRuleCondition],
        rule_match: RevenexxEnums.SegmentRulePreviewRequestRuleMatch?,
        target: RevenexxEnums.SegmentRulePreviewRequestTarget?
    ) {
        self.conditions = conditions
        self.rule_match = rule_match
        self.target = target
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.conditions = try container.decode([SegmentRuleCondition].self, forKey: .conditions)
        if let rule_matchString = try container.decodeIfPresent(String.self, forKey: .rule_match) {
            self.rule_match = RevenexxEnums.SegmentRulePreviewRequestRuleMatch(rawValue: rule_matchString)
        } else {
            self.rule_match = nil
        }
        if let targetString = try container.decodeIfPresent(String.self, forKey: .target) {
            self.target = RevenexxEnums.SegmentRulePreviewRequestTarget(rawValue: targetString)
        } else {
            self.target = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(conditions, forKey: .conditions)
        try container.encodeIfPresent(rule_match?.rawValue, forKey: .rule_match)
        try container.encodeIfPresent(target?.rawValue, forKey: .target)
    }

    public func toMap() -> [String: Any] {
        return [
            "conditions": conditions.map { $0.toMap() } as Any,
            "rule_match": rule_match?.rawValue as Any,
            "target": target?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentRulePreviewRequest {
        return SegmentRulePreviewRequest(
            conditions: (map["conditions"] as! [[String: Any]]).map { SegmentRuleCondition.from(map: $0) },
            rule_match: map["rule_match"] as? String != nil ? SegmentRulePreviewRequestRuleMatch(rawValue: map["rule_match"] as! String) : nil,
            target: map["target"] as? String != nil ? SegmentRulePreviewRequestTarget(rawValue: map["target"] as! String) : nil
        )
    }
}
