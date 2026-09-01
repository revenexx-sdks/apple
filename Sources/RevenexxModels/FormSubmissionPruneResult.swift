import Foundation
import JSONCodable

/// 
open class FormSubmissionPruneResult: Codable {

    enum CodingKeys: String, CodingKey {
        case cutoff = "cutoff"
        case deleted = "deleted"
        case dry_run = "dry_run"
        case floor_applied = "floor_applied"
        case matched = "matched"
        case older_than_days = "older_than_days"
        case remaining = "remaining"
        case retention_days = "retention_days"
        case retention_market = "retention_market"
        case sample = "sample"
    }

    /// Submissions created before this instant match. It is `now - older_than_days`, computed after the retention floor was applied, so it is the honest answer to "what did this call actually consider".
    public let cutoff: String?
    /// How many rows this call actually removed — always 0 on a dry run, and at most the 500-row batch size on a real one.
    public let deleted: Int?
    /// Whether this call was a preview. True — the default — means nothing was deleted and `matched` is what a real run would take.
    public let dry_run: Bool?
    /// True when the request asked for a shorter age than the floor allows.
    public let floor_applied: Bool?
    /// How many rows match, ignoring the batch size.
    public let matched: Int?
    /// The threshold actually applied, after the retention floor.
    public let older_than_days: Double?
    /// Matched rows left after this batch — call again. Absent on a dry run, which deletes nothing.
    public let remaining: Int?
    /// The retention floor this sweep honoured: the LONGEST submission_retention_days configured anywhere in the tenant, baseline or market. Not the value the calling market sees — a tenant-wide sweep has to keep the longest promise anybody was given.
    public let retention_days: Double?
    /// The market whose submission_retention_days set the floor — the merchant's own market CODE — or null when the tenant baseline did. It is there so a merchant can see WHY the sweep would not go younger, since the market that bound it is often not the one the request was made from.
    public let retention_market: String?
    /// Up to five matching rows (dry runs only) — id, form_slug and created_at, never the submitted data.
    public let sample: [FormSubmissionPruneSample]?

    init(
        cutoff: String?,
        deleted: Int?,
        dry_run: Bool?,
        floor_applied: Bool?,
        matched: Int?,
        older_than_days: Double?,
        remaining: Int?,
        retention_days: Double?,
        retention_market: String?,
        sample: [FormSubmissionPruneSample]?
    ) {
        self.cutoff = cutoff
        self.deleted = deleted
        self.dry_run = dry_run
        self.floor_applied = floor_applied
        self.matched = matched
        self.older_than_days = older_than_days
        self.remaining = remaining
        self.retention_days = retention_days
        self.retention_market = retention_market
        self.sample = sample
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cutoff = try container.decodeIfPresent(String.self, forKey: .cutoff)
        self.deleted = try container.decodeIfPresent(Int.self, forKey: .deleted)
        self.dry_run = try container.decodeIfPresent(Bool.self, forKey: .dry_run)
        self.floor_applied = try container.decodeIfPresent(Bool.self, forKey: .floor_applied)
        self.matched = try container.decodeIfPresent(Int.self, forKey: .matched)
        self.older_than_days = try container.decodeIfPresent(Double.self, forKey: .older_than_days)
        self.remaining = try container.decodeIfPresent(Int.self, forKey: .remaining)
        self.retention_days = try container.decodeIfPresent(Double.self, forKey: .retention_days)
        self.retention_market = try container.decodeIfPresent(String.self, forKey: .retention_market)
        self.sample = try container.decodeIfPresent([FormSubmissionPruneSample].self, forKey: .sample)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cutoff, forKey: .cutoff)
        try container.encodeIfPresent(deleted, forKey: .deleted)
        try container.encodeIfPresent(dry_run, forKey: .dry_run)
        try container.encodeIfPresent(floor_applied, forKey: .floor_applied)
        try container.encodeIfPresent(matched, forKey: .matched)
        try container.encodeIfPresent(older_than_days, forKey: .older_than_days)
        try container.encodeIfPresent(remaining, forKey: .remaining)
        try container.encodeIfPresent(retention_days, forKey: .retention_days)
        try container.encodeIfPresent(retention_market, forKey: .retention_market)
        try container.encodeIfPresent(sample, forKey: .sample)
    }

    public func toMap() -> [String: Any] {
        return [
            "cutoff": cutoff as Any,
            "deleted": deleted as Any,
            "dry_run": dry_run as Any,
            "floor_applied": floor_applied as Any,
            "matched": matched as Any,
            "older_than_days": older_than_days as Any,
            "remaining": remaining as Any,
            "retention_days": retention_days as Any,
            "retention_market": retention_market as Any,
            "sample": sample?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormSubmissionPruneResult {
        return FormSubmissionPruneResult(
            cutoff: map["cutoff"] as? String,
            deleted: map["deleted"] as? Int,
            dry_run: map["dry_run"] as? Bool,
            floor_applied: map["floor_applied"] as? Bool,
            matched: map["matched"] as? Int,
            older_than_days: map["older_than_days"] as? Double,
            remaining: map["remaining"] as? Int,
            retention_days: map["retention_days"] as? Double,
            retention_market: map["retention_market"] as? String,
            sample: (map["sample"] as? [[String: Any]] ?? []).map { FormSubmissionPruneSample.from(map: $0) }
        )
    }
}
