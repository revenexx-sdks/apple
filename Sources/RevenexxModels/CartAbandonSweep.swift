import Foundation
import JSONCodable

/// The first sweep: active carts nobody has touched since their market's window become abandoned. Nothing else in the platform ever stamps abandoned_at, so without this the abandonment funnel is empty by construction rather than empty because nobody abandons carts.
open class CartAbandonSweep: Codable {

    enum CodingKeys: String, CodingKey {
        case abandoned = "abandoned"
        case after_minutes = "after_minutes"
        case capped = "capped"
        case cart_ids = "cart_ids"
        case cutoff = "cutoff"
        case enabled = "enabled"
        case found = "found"
        case markets = "markets"
    }

    /// Carts actually marked. 0 on a dry run — see `found`.
    public let abandoned: Int?
    /// The abandon_after_minutes of the TENANT baseline — what a cart in no market ran on. 0 disables the sweep. Carts in a market were each held against their own market's window, which may differ from this.
    public let after_minutes: Double?
    /// This pass looked at as many carts as one pass looks at, so there may be more behind them. The rest go on the next tick, oldest first — a backlog is visible here rather than merely slow.
    public let capped: Bool?
    /// The carts this sweep touched, so a merchant can look at them before or after.
    public let cart_ids: [String]?
    /// Carts untouched since this instant were swept — the BASELINE cutoff. A run no longer has one cutoff, because each cart was held against its own market's clock; this is the one unassigned carts ran on.
    public let cutoff: String?
    /// At least one window in force (the baseline, or some market's). False means every applicable window was 0 and nothing was even considered.
    public let enabled: Bool?
    /// Carts past their window. On a dry run this is the whole answer — `abandoned` stays 0.
    public let found: Int?
    /// The market codes this pass came across, so an operator can see whose windows were actually in play. Empty when no examined cart belongs to a market.
    public let markets: [String]?

    init(
        abandoned: Int?,
        after_minutes: Double?,
        capped: Bool?,
        cart_ids: [String]?,
        cutoff: String?,
        enabled: Bool?,
        found: Int?,
        markets: [String]?
    ) {
        self.abandoned = abandoned
        self.after_minutes = after_minutes
        self.capped = capped
        self.cart_ids = cart_ids
        self.cutoff = cutoff
        self.enabled = enabled
        self.found = found
        self.markets = markets
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.abandoned = try container.decodeIfPresent(Int.self, forKey: .abandoned)
        self.after_minutes = try container.decodeIfPresent(Double.self, forKey: .after_minutes)
        self.capped = try container.decodeIfPresent(Bool.self, forKey: .capped)
        self.cart_ids = try container.decodeIfPresent([String].self, forKey: .cart_ids)
        self.cutoff = try container.decodeIfPresent(String.self, forKey: .cutoff)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.found = try container.decodeIfPresent(Int.self, forKey: .found)
        self.markets = try container.decodeIfPresent([String].self, forKey: .markets)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(abandoned, forKey: .abandoned)
        try container.encodeIfPresent(after_minutes, forKey: .after_minutes)
        try container.encodeIfPresent(capped, forKey: .capped)
        try container.encodeIfPresent(cart_ids, forKey: .cart_ids)
        try container.encodeIfPresent(cutoff, forKey: .cutoff)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(found, forKey: .found)
        try container.encodeIfPresent(markets, forKey: .markets)
    }

    public func toMap() -> [String: Any] {
        return [
            "abandoned": abandoned as Any,
            "after_minutes": after_minutes as Any,
            "capped": capped as Any,
            "cart_ids": cart_ids as Any,
            "cutoff": cutoff as Any,
            "enabled": enabled as Any,
            "found": found as Any,
            "markets": markets as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartAbandonSweep {
        return CartAbandonSweep(
            abandoned: map["abandoned"] as? Int,
            after_minutes: map["after_minutes"] as? Double,
            capped: map["capped"] as? Bool,
            cart_ids: map["cart_ids"] as? [String],
            cutoff: map["cutoff"] as? String,
            enabled: map["enabled"] as? Bool,
            found: map["found"] as? Int,
            markets: map["markets"] as? [String]
        )
    }
}
