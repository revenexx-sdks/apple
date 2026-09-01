import Foundation
import JSONCodable
import RevenexxEnums

/// Change every priced entry of a list at once. Send 'percent' OR 'amount', never both. On-request entries are never touched — a percentage of "ask us" is not a number.
open class PriceEntriesAdjustRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case dry_run = "dry_run"
        case percent = "percent"
        case rounding = "rounding"
        case sku_prefix = "sku_prefix"
    }

    /// Absolute change added to every unit price, in the list's currency.
    public let amount: Double?
    /// true writes nothing and answers the same preview — what the Cockpit dialog shows before it commits.
    public let dry_run: Bool?
    /// Relative change in percent: 5 raises by 5 %, -10 cuts by 10 %.
    public let percent: Double?
    /// Ending the computed prices snap to (nearest match). Omit to use the tenant's bulk_adjust_rounding setting.
    public let rounding: RevenexxEnums.PriceEndingRule?
    /// Restrict the change to entries whose SKU starts with this (a prefix, case-sensitive, no wildcards). Entries identified only by product_id never match a prefix. Omit to change the whole list.
    public let sku_prefix: String?

    init(
        amount: Double?,
        dry_run: Bool?,
        percent: Double?,
        rounding: RevenexxEnums.PriceEndingRule?,
        sku_prefix: String?
    ) {
        self.amount = amount
        self.dry_run = dry_run
        self.percent = percent
        self.rounding = rounding
        self.sku_prefix = sku_prefix
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        self.dry_run = try container.decodeIfPresent(Bool.self, forKey: .dry_run)
        self.percent = try container.decodeIfPresent(Double.self, forKey: .percent)
        if let roundingString = try container.decodeIfPresent(String.self, forKey: .rounding) {
            self.rounding = RevenexxEnums.PriceEndingRule(rawValue: roundingString)
        } else {
            self.rounding = nil
        }
        self.sku_prefix = try container.decodeIfPresent(String.self, forKey: .sku_prefix)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(dry_run, forKey: .dry_run)
        try container.encodeIfPresent(percent, forKey: .percent)
        try container.encodeIfPresent(rounding?.rawValue, forKey: .rounding)
        try container.encodeIfPresent(sku_prefix, forKey: .sku_prefix)
    }

    public func toMap() -> [String: Any] {
        return [
            "amount": amount as Any,
            "dry_run": dry_run as Any,
            "percent": percent as Any,
            "rounding": rounding?.rawValue as Any,
            "sku_prefix": sku_prefix as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesAdjustRequest {
        return PriceEntriesAdjustRequest(
            amount: map["amount"] as? Double,
            dry_run: map["dry_run"] as? Bool,
            percent: map["percent"] as? Double,
            rounding: map["rounding"] as? String != nil ? PriceEndingRule(rawValue: map["rounding"] as! String) : nil,
            sku_prefix: map["sku_prefix"] as? String
        )
    }
}
