import Foundation
import JSONCodable
import RevenexxEnums

/// What the change did (or would do, on a dry run), plus the rounding policy it was computed under — so a dialog can show a merchant the before/after before it commits.
open class PriceEntriesAdjustResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case dry_run = "dry_run"
        case matched = "matched"
        case precision = "precision"
        case preview = "preview"
        case preview_truncated = "preview_truncated"
        case price_list = "price_list"
        case rounding = "rounding"
        case rounding_mode = "rounding_mode"
        case updated = "updated"
    }

    /// Echo of the request: true means nothing was written.
    public let dry_run: Bool?
    /// Priced entries the filter selected. On-request entries are never counted — a percentage of "ask us" is not a number.
    public let matched: Int?
    /// Decimals the new prices were rounded to before snapping — the tenant’s price_precision.
    public let precision: Int?
    /// The first 50 changes, before and after. `matched` says how many there were in total.
    public let preview: [PriceAdjustPreviewRow]?
    /// true when more than 50 entries changed, so `preview` is a sample rather than the whole set.
    public let preview_truncated: Bool?
    /// The price list this answer came out of — enough to link to it or to explain the number to a merchant ("this came from the dealer list").
    public let price_list: PriceListRef?
    /// The price ending the results were snapped to — the request’s, or the tenant’s bulk_adjust_rounding where it sent none.
    public let rounding: RevenexxEnums.PriceEntriesAdjustResponseRounding?
    /// How they landed on the last decimal — the tenant’s rounding_mode.
    public let rounding_mode: RevenexxEnums.PriceEntriesAdjustResponseRoundingMode?
    /// Rows actually written — 0 on a dry run, and a price that came out unchanged is not rewritten.
    public let updated: Int?

    init(
        dry_run: Bool?,
        matched: Int?,
        precision: Int?,
        preview: [PriceAdjustPreviewRow]?,
        preview_truncated: Bool?,
        price_list: PriceListRef?,
        rounding: RevenexxEnums.PriceEntriesAdjustResponseRounding?,
        rounding_mode: RevenexxEnums.PriceEntriesAdjustResponseRoundingMode?,
        updated: Int?
    ) {
        self.dry_run = dry_run
        self.matched = matched
        self.precision = precision
        self.preview = preview
        self.preview_truncated = preview_truncated
        self.price_list = price_list
        self.rounding = rounding
        self.rounding_mode = rounding_mode
        self.updated = updated
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.dry_run = try container.decodeIfPresent(Bool.self, forKey: .dry_run)
        self.matched = try container.decodeIfPresent(Int.self, forKey: .matched)
        self.precision = try container.decodeIfPresent(Int.self, forKey: .precision)
        self.preview = try container.decodeIfPresent([PriceAdjustPreviewRow].self, forKey: .preview)
        self.preview_truncated = try container.decodeIfPresent(Bool.self, forKey: .preview_truncated)
        self.price_list = try container.decodeIfPresent(PriceListRef.self, forKey: .price_list)
        if let roundingString = try container.decodeIfPresent(String.self, forKey: .rounding) {
            self.rounding = RevenexxEnums.PriceEntriesAdjustResponseRounding(rawValue: roundingString)
        } else {
            self.rounding = nil
        }
        if let rounding_modeString = try container.decodeIfPresent(String.self, forKey: .rounding_mode) {
            self.rounding_mode = RevenexxEnums.PriceEntriesAdjustResponseRoundingMode(rawValue: rounding_modeString)
        } else {
            self.rounding_mode = nil
        }
        self.updated = try container.decodeIfPresent(Int.self, forKey: .updated)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(dry_run, forKey: .dry_run)
        try container.encodeIfPresent(matched, forKey: .matched)
        try container.encodeIfPresent(precision, forKey: .precision)
        try container.encodeIfPresent(preview, forKey: .preview)
        try container.encodeIfPresent(preview_truncated, forKey: .preview_truncated)
        try container.encodeIfPresent(price_list, forKey: .price_list)
        try container.encodeIfPresent(rounding?.rawValue, forKey: .rounding)
        try container.encodeIfPresent(rounding_mode?.rawValue, forKey: .rounding_mode)
        try container.encodeIfPresent(updated, forKey: .updated)
    }

    public func toMap() -> [String: Any] {
        return [
            "dry_run": dry_run as Any,
            "matched": matched as Any,
            "precision": precision as Any,
            "preview": preview?.map { $0.toMap() } as Any,
            "preview_truncated": preview_truncated as Any,
            "price_list": price_list?.toMap() as Any,
            "rounding": rounding?.rawValue as Any,
            "rounding_mode": rounding_mode?.rawValue as Any,
            "updated": updated as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesAdjustResponse {
        return PriceEntriesAdjustResponse(
            dry_run: map["dry_run"] as? Bool,
            matched: map["matched"] as? Int,
            precision: map["precision"] as? Int,
            preview: (map["preview"] as? [[String: Any]] ?? []).map { PriceAdjustPreviewRow.from(map: $0) },
            preview_truncated: map["preview_truncated"] as? Bool,
            price_list: PriceListRef.from(map: map["price_list"] as! [String: Any]),
            rounding: map["rounding"] as? String != nil ? PriceEntriesAdjustResponseRounding(rawValue: map["rounding"] as! String) : nil,
            rounding_mode: map["rounding_mode"] as? String != nil ? PriceEntriesAdjustResponseRoundingMode(rawValue: map["rounding_mode"] as! String) : nil,
            updated: map["updated"] as? Int
        )
    }
}
