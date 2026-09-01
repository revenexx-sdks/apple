import Foundation
import JSONCodable
import RevenexxEnums

/// How price_snapshot_mode settled the two prices every line carries.
open class CartConversionPricing: Codable {

    enum CodingKeys: String, CodingKey {
        case lines = "lines"
        case lines_changed = "lines_changed"
        case mode = "mode"
        case subtotal_after = "subtotal_after"
        case subtotal_before = "subtotal_before"
    }

    /// Lines in the cart when it converted.
    public let lines: Int?
    /// Lines the mode had to rewrite because snapshot and unit_price disagreed — repriced in 'snapshot' mode, re-snapshotted in 'live' mode. A line whose snapshot carries no readable price is never touched in either mode.
    public let lines_changed: Int?
    /// The tenant's price_snapshot_mode, as it ran. 'snapshot' books the order on the price the buyer was shown; 'live' books it on the line's current unit_price and rewrites the snapshot to agree, so the frozen line never claims a price nobody was charged.
    public let mode: RevenexxEnums.CartPriceSnapshotMode?
    /// The cart's frozen subtotal, and what the order is booked on.
    public let subtotal_after: Double?
    /// The cart's subtotal as it stood before the mode was applied. Compare it with subtotal_after and 'why is the order €4 off the cart' is answered by the response instead of by an argument.
    public let subtotal_before: Double?

    init(
        lines: Int?,
        lines_changed: Int?,
        mode: RevenexxEnums.CartPriceSnapshotMode?,
        subtotal_after: Double?,
        subtotal_before: Double?
    ) {
        self.lines = lines
        self.lines_changed = lines_changed
        self.mode = mode
        self.subtotal_after = subtotal_after
        self.subtotal_before = subtotal_before
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.lines = try container.decodeIfPresent(Int.self, forKey: .lines)
        self.lines_changed = try container.decodeIfPresent(Int.self, forKey: .lines_changed)
        if let modeString = try container.decodeIfPresent(String.self, forKey: .mode) {
            self.mode = RevenexxEnums.CartPriceSnapshotMode(rawValue: modeString)
        } else {
            self.mode = nil
        }
        self.subtotal_after = try container.decodeIfPresent(Double.self, forKey: .subtotal_after)
        self.subtotal_before = try container.decodeIfPresent(Double.self, forKey: .subtotal_before)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(lines, forKey: .lines)
        try container.encodeIfPresent(lines_changed, forKey: .lines_changed)
        try container.encodeIfPresent(mode?.rawValue, forKey: .mode)
        try container.encodeIfPresent(subtotal_after, forKey: .subtotal_after)
        try container.encodeIfPresent(subtotal_before, forKey: .subtotal_before)
    }

    public func toMap() -> [String: Any] {
        return [
            "lines": lines as Any,
            "lines_changed": lines_changed as Any,
            "mode": mode?.rawValue as Any,
            "subtotal_after": subtotal_after as Any,
            "subtotal_before": subtotal_before as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartConversionPricing {
        return CartConversionPricing(
            lines: map["lines"] as? Int,
            lines_changed: map["lines_changed"] as? Int,
            mode: map["mode"] as? String != nil ? CartPriceSnapshotMode(rawValue: map["mode"] as! String) : nil,
            subtotal_after: map["subtotal_after"] as? Double,
            subtotal_before: map["subtotal_before"] as? Double
        )
    }
}
