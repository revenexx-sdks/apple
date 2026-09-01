import Foundation
import JSONCodable

/// 
open class SegmentRuleRecomputeAllResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case added = "added"
        case done = "done"
        case failed = "failed"
        case processed = "processed"
        case removed = "removed"
        case segments = "segments"
        case skipped = "skipped"
    }

    /// Rule memberships inserted across every segment in THIS call.
    public let added: Int?
    /// False when any segment is unfinished or skipped — call again.
    public let done: Bool?
    /// Segments whose own recompute raised — they carry `error` and `status` in `segments` and did not abort the run.
    public let failed: Int?
    /// Ruled segments the run looked at.
    public let processed: Int?
    /// Rule memberships deleted across every segment in THIS call.
    public let removed: Int?
    /// One entry per segment; a failed segment carries `error` and `status` instead of the counters.
    public let segments: [[String: AnyCodable]]?
    /// Segments the budget did not reach at all.
    public let skipped: Int?

    init(
        added: Int?,
        done: Bool?,
        failed: Int?,
        processed: Int?,
        removed: Int?,
        segments: [[String: AnyCodable]]?,
        skipped: Int?
    ) {
        self.added = added
        self.done = done
        self.failed = failed
        self.processed = processed
        self.removed = removed
        self.segments = segments
        self.skipped = skipped
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.added = try container.decodeIfPresent(Int.self, forKey: .added)
        self.done = try container.decodeIfPresent(Bool.self, forKey: .done)
        self.failed = try container.decodeIfPresent(Int.self, forKey: .failed)
        self.processed = try container.decodeIfPresent(Int.self, forKey: .processed)
        self.removed = try container.decodeIfPresent(Int.self, forKey: .removed)
        self.segments = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .segments)
        self.skipped = try container.decodeIfPresent(Int.self, forKey: .skipped)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(added, forKey: .added)
        try container.encodeIfPresent(done, forKey: .done)
        try container.encodeIfPresent(failed, forKey: .failed)
        try container.encodeIfPresent(processed, forKey: .processed)
        try container.encodeIfPresent(removed, forKey: .removed)
        try container.encodeIfPresent(segments, forKey: .segments)
        try container.encodeIfPresent(skipped, forKey: .skipped)
    }

    public func toMap() -> [String: Any] {
        return [
            "added": added as Any,
            "done": done as Any,
            "failed": failed as Any,
            "processed": processed as Any,
            "removed": removed as Any,
            "segments": segments as Any,
            "skipped": skipped as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentRuleRecomputeAllResponse {
        return SegmentRuleRecomputeAllResponse(
            added: map["added"] as? Int,
            done: map["done"] as? Bool,
            failed: map["failed"] as? Int,
            processed: map["processed"] as? Int,
            removed: map["removed"] as? Int,
            segments: map["segments"] as? [[String: AnyCodable]],
            skipped: map["skipped"] as? Int
        )
    }
}
