import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class SegmentRulePreviewResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case cap = "cap"
        case capped = "capped"
        case count = "count"
        case rule_match = "rule_match"
        case sample = "sample"
        case segment_id = "segment_id"
        case target = "target"
    }

    /// The cap that applied (5000), or null when the rule was answered by a single count query and no cap was needed.
    public let cap: Int?
    /// True when the combined evaluation hit the id cap, which makes `count` a lower bound.
    public let capped: Bool?
    /// How many organizations the rule selects. Exact when 'capped' is false; a LOWER BOUND when it is true.
    public let count: Int?
    /// How the conditions were combined for this preview.
    public let rule_match: RevenexxEnums.SegmentRulePreviewResponseRuleMatch?
    /// A handful of the organizations the rule selects — enough for an operator to recognise whether the rule means what they thought. Never the full set.
    public let sample: [[String: AnyCodable]]?
    /// The segment named in the path. It is not read — the rule comes from the body — but it has to exist.
    public let segment_id: String?
    /// What the rule selects. Only 'organizations' exists.
    public let target: RevenexxEnums.SegmentRulePreviewResponseTarget?

    init(
        cap: Int?,
        capped: Bool?,
        count: Int?,
        rule_match: RevenexxEnums.SegmentRulePreviewResponseRuleMatch?,
        sample: [[String: AnyCodable]]?,
        segment_id: String?,
        target: RevenexxEnums.SegmentRulePreviewResponseTarget?
    ) {
        self.cap = cap
        self.capped = capped
        self.count = count
        self.rule_match = rule_match
        self.sample = sample
        self.segment_id = segment_id
        self.target = target
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cap = try container.decodeIfPresent(Int.self, forKey: .cap)
        self.capped = try container.decodeIfPresent(Bool.self, forKey: .capped)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        if let rule_matchString = try container.decodeIfPresent(String.self, forKey: .rule_match) {
            self.rule_match = RevenexxEnums.SegmentRulePreviewResponseRuleMatch(rawValue: rule_matchString)
        } else {
            self.rule_match = nil
        }
        self.sample = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .sample)
        self.segment_id = try container.decodeIfPresent(String.self, forKey: .segment_id)
        if let targetString = try container.decodeIfPresent(String.self, forKey: .target) {
            self.target = RevenexxEnums.SegmentRulePreviewResponseTarget(rawValue: targetString)
        } else {
            self.target = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cap, forKey: .cap)
        try container.encodeIfPresent(capped, forKey: .capped)
        try container.encodeIfPresent(count, forKey: .count)
        try container.encodeIfPresent(rule_match?.rawValue, forKey: .rule_match)
        try container.encodeIfPresent(sample, forKey: .sample)
        try container.encodeIfPresent(segment_id, forKey: .segment_id)
        try container.encodeIfPresent(target?.rawValue, forKey: .target)
    }

    public func toMap() -> [String: Any] {
        return [
            "cap": cap as Any,
            "capped": capped as Any,
            "count": count as Any,
            "rule_match": rule_match?.rawValue as Any,
            "sample": sample as Any,
            "segment_id": segment_id as Any,
            "target": target?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentRulePreviewResponse {
        return SegmentRulePreviewResponse(
            cap: map["cap"] as? Int,
            capped: map["capped"] as? Bool,
            count: map["count"] as? Int,
            rule_match: map["rule_match"] as? String != nil ? SegmentRulePreviewResponseRuleMatch(rawValue: map["rule_match"] as! String) : nil,
            sample: map["sample"] as? [[String: AnyCodable]],
            segment_id: map["segment_id"] as? String,
            target: map["target"] as? String != nil ? SegmentRulePreviewResponseTarget(rawValue: map["target"] as! String) : nil
        )
    }
}
