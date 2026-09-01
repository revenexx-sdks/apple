import Foundation
import JSONCodable

/// 
open class CategoryRecomputeSummary: Codable {

    enum CodingKeys: String, CodingKey {
        case added = "added"
        case batched = "batched"
        case category_id = "category_id"
        case code = "code"
        case computed_at = "computed_at"
        case cursor = "cursor"
        case done = "done"
        case error = "error"
        case processed = "processed"
        case removed = "removed"
        case skipped = "skipped"
        case status = "status"
        case total = "total"
    }

    /// Membership rows inserted with source='rule' by this call.
    public let added: Int?
    /// False → the bulk insert was refused and the call fell back to one request per row. A performance fact, not an error.
    public let batched: Bool?
    /// The category this pass belongs to, echoed back — a caller driving several loops keys its state by it.
    public let category_id: String?
    /// The category's code, so a nightly log names something a person recognises.
    public let code: String?
    /// When the pass completed, and what `categories.rules_computed_at` was stamped with. Null while `done` is false.
    public let computed_at: String?
    /// The product id this call reconciled up to, to hand back on the next one. Null when `done`.
    public let cursor: String?
    /// False → this call spent its budget mid-pass. Send `cursor` back to continue; the counters below are THIS call only, so a caller looping to completion sums them itself.
    public let done: Bool?
    /// Present instead of the counters when this category failed.
    public let error: String?
    /// Matching products examined by this call.
    public let processed: Int?
    /// Stale rule rows deleted by this call.
    public let removed: Int?
    /// True → the budget ran out before this category was reached; it carries no counters.
    public let skipped: Bool?
    /// The HTTP status this category WOULD have answered on its own — 400 for a rule that does not compile, 404 for one that vanished mid-run. Null when it succeeded.
    public let status: Int?
    /// Products the rule currently selects. Null while `done` is false — the pass has not seen the whole catalog yet, so there is no total to report.
    public let total: Int?

    init(
        added: Int?,
        batched: Bool?,
        category_id: String?,
        code: String?,
        computed_at: String?,
        cursor: String?,
        done: Bool?,
        error: String?,
        processed: Int?,
        removed: Int?,
        skipped: Bool?,
        status: Int?,
        total: Int?
    ) {
        self.added = added
        self.batched = batched
        self.category_id = category_id
        self.code = code
        self.computed_at = computed_at
        self.cursor = cursor
        self.done = done
        self.error = error
        self.processed = processed
        self.removed = removed
        self.skipped = skipped
        self.status = status
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.added = try container.decodeIfPresent(Int.self, forKey: .added)
        self.batched = try container.decodeIfPresent(Bool.self, forKey: .batched)
        self.category_id = try container.decodeIfPresent(String.self, forKey: .category_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.computed_at = try container.decodeIfPresent(String.self, forKey: .computed_at)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.done = try container.decodeIfPresent(Bool.self, forKey: .done)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
        self.processed = try container.decodeIfPresent(Int.self, forKey: .processed)
        self.removed = try container.decodeIfPresent(Int.self, forKey: .removed)
        self.skipped = try container.decodeIfPresent(Bool.self, forKey: .skipped)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(added, forKey: .added)
        try container.encodeIfPresent(batched, forKey: .batched)
        try container.encodeIfPresent(category_id, forKey: .category_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(computed_at, forKey: .computed_at)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(done, forKey: .done)
        try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(processed, forKey: .processed)
        try container.encodeIfPresent(removed, forKey: .removed)
        try container.encodeIfPresent(skipped, forKey: .skipped)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "added": added as Any,
            "batched": batched as Any,
            "category_id": category_id as Any,
            "code": code as Any,
            "computed_at": computed_at as Any,
            "cursor": cursor as Any,
            "done": done as Any,
            "error": error as Any,
            "processed": processed as Any,
            "removed": removed as Any,
            "skipped": skipped as Any,
            "status": status as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CategoryRecomputeSummary {
        return CategoryRecomputeSummary(
            added: map["added"] as? Int,
            batched: map["batched"] as? Bool,
            category_id: map["category_id"] as? String,
            code: map["code"] as? String,
            computed_at: map["computed_at"] as? String,
            cursor: map["cursor"] as? String,
            done: map["done"] as? Bool,
            error: map["error"] as? String,
            processed: map["processed"] as? Int,
            removed: map["removed"] as? Int,
            skipped: map["skipped"] as? Bool,
            status: map["status"] as? Int,
            total: map["total"] as? Int
        )
    }
}
