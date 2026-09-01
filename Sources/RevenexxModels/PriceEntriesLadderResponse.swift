import Foundation
import JSONCodable
import RevenexxEnums

/// The generated ladder as stored, plus the rounding policy that shaped it.
open class PriceEntriesLadderResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case entries = "entries"
        case precision = "precision"
        case replaced = "replaced"
        case rounding = "rounding"
        case rounding_mode = "rounding_mode"
    }

    /// The generated rungs, one per requested quantity, ascending — this IS the item's ladder in this list.
    public let entries: [PriceEntry]?
    /// Decimals each tier was rounded to before snapping — the tenant's price_precision.
    public let precision: Int?
    /// true when the item's existing entries in this list were removed first (the default), so the answer is the whole ladder rather than an addition to one.
    public let replaced: Bool?
    /// The price ending each tier was snapped to — the request's, or the tenant's bulk_adjust_rounding.
    public let rounding: RevenexxEnums.PriceEndingRule?
    /// How they landed on the last decimal — the tenant's rounding_mode.
    public let rounding_mode: RevenexxEnums.PriceRoundingMode?

    init(
        entries: [PriceEntry]?,
        precision: Int?,
        replaced: Bool?,
        rounding: RevenexxEnums.PriceEndingRule?,
        rounding_mode: RevenexxEnums.PriceRoundingMode?
    ) {
        self.entries = entries
        self.precision = precision
        self.replaced = replaced
        self.rounding = rounding
        self.rounding_mode = rounding_mode
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.entries = try container.decodeIfPresent([PriceEntry].self, forKey: .entries)
        self.precision = try container.decodeIfPresent(Int.self, forKey: .precision)
        self.replaced = try container.decodeIfPresent(Bool.self, forKey: .replaced)
        if let roundingString = try container.decodeIfPresent(String.self, forKey: .rounding) {
            self.rounding = RevenexxEnums.PriceEndingRule(rawValue: roundingString)
        } else {
            self.rounding = nil
        }
        if let rounding_modeString = try container.decodeIfPresent(String.self, forKey: .rounding_mode) {
            self.rounding_mode = RevenexxEnums.PriceRoundingMode(rawValue: rounding_modeString)
        } else {
            self.rounding_mode = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(entries, forKey: .entries)
        try container.encodeIfPresent(precision, forKey: .precision)
        try container.encodeIfPresent(replaced, forKey: .replaced)
        try container.encodeIfPresent(rounding?.rawValue, forKey: .rounding)
        try container.encodeIfPresent(rounding_mode?.rawValue, forKey: .rounding_mode)
    }

    public func toMap() -> [String: Any] {
        return [
            "entries": entries?.map { $0.toMap() } as Any,
            "precision": precision as Any,
            "replaced": replaced as Any,
            "rounding": rounding?.rawValue as Any,
            "rounding_mode": rounding_mode?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesLadderResponse {
        return PriceEntriesLadderResponse(
            entries: (map["entries"] as? [[String: Any]] ?? []).map { PriceEntry.from(map: $0) },
            precision: map["precision"] as? Int,
            replaced: map["replaced"] as? Bool,
            rounding: map["rounding"] as? String != nil ? PriceEndingRule(rawValue: map["rounding"] as! String) : nil,
            rounding_mode: map["rounding_mode"] as? String != nil ? PriceRoundingMode(rawValue: map["rounding_mode"] as! String) : nil
        )
    }
}
