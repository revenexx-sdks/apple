import Foundation
import JSONCodable

/// 
open class SegmentRuleRecomputeResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case added = "added"
        case batched = "batched"
        case computed_at = "computed_at"
        case cursor = "cursor"
        case done = "done"
        case processed = "processed"
        case removed = "removed"
        case segment_id = "segment_id"
        case total = "total"
    }

    /// Rule memberships inserted by THIS call.
    public let added: Int?
    /// True when every membership insert used a bulk array request; false if any batch fell back to row-at-a-time.
    public let batched: Bool?
    /// Set when the pass completes.
    public let computed_at: String?
    /// Send back on the next call; null when the pass is done.
    public let cursor: String?
    /// False means work remains — POST again with `cursor`.
    public let done: Bool?
    /// Matching organizations examined by THIS call.
    public let processed: Int?
    /// Rule memberships deleted by THIS call.
    public let removed: Int?
    /// The segment that was recomputed.
    public let segment_id: String?
    /// The rule's full match count; null until done.
    public let total: Int?

    init(
        added: Int?,
        batched: Bool?,
        computed_at: String?,
        cursor: String?,
        done: Bool?,
        processed: Int?,
        removed: Int?,
        segment_id: String?,
        total: Int?
    ) {
        self.added = added
        self.batched = batched
        self.computed_at = computed_at
        self.cursor = cursor
        self.done = done
        self.processed = processed
        self.removed = removed
        self.segment_id = segment_id
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.added = try container.decodeIfPresent(Int.self, forKey: .added)
        self.batched = try container.decodeIfPresent(Bool.self, forKey: .batched)
        self.computed_at = try container.decodeIfPresent(String.self, forKey: .computed_at)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.done = try container.decodeIfPresent(Bool.self, forKey: .done)
        self.processed = try container.decodeIfPresent(Int.self, forKey: .processed)
        self.removed = try container.decodeIfPresent(Int.self, forKey: .removed)
        self.segment_id = try container.decodeIfPresent(String.self, forKey: .segment_id)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(added, forKey: .added)
        try container.encodeIfPresent(batched, forKey: .batched)
        try container.encodeIfPresent(computed_at, forKey: .computed_at)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(done, forKey: .done)
        try container.encodeIfPresent(processed, forKey: .processed)
        try container.encodeIfPresent(removed, forKey: .removed)
        try container.encodeIfPresent(segment_id, forKey: .segment_id)
        try container.encodeIfPresent(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "added": added as Any,
            "batched": batched as Any,
            "computed_at": computed_at as Any,
            "cursor": cursor as Any,
            "done": done as Any,
            "processed": processed as Any,
            "removed": removed as Any,
            "segment_id": segment_id as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentRuleRecomputeResponse {
        return SegmentRuleRecomputeResponse(
            added: map["added"] as? Int,
            batched: map["batched"] as? Bool,
            computed_at: map["computed_at"] as? String,
            cursor: map["cursor"] as? String,
            done: map["done"] as? Bool,
            processed: map["processed"] as? Int,
            removed: map["removed"] as? Int,
            segment_id: map["segment_id"] as? String,
            total: map["total"] as? Int
        )
    }
}
