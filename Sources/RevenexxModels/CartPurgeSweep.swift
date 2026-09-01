import Foundation
import JSONCodable

/// The second sweep, and the only destructive thing this app does: carts past their retention window are deleted, their lines with them. An ordered cart is never touched at any setting — it is the source record of a sale.
open class CartPurgeSweep: Codable {

    enum CodingKeys: String, CodingKey {
        case capped = "capped"
        case cart_ids = "cart_ids"
        case cart_ttl_days = "cart_ttl_days"
        case cutoff = "cutoff"
        case deleted = "deleted"
        case enabled = "enabled"
        case found = "found"
        case guest_cart_ttl_days = "guest_cart_ttl_days"
        case items_deleted = "items_deleted"
        case markets = "markets"
        case would_delete_items = "would_delete_items"
    }

    /// More carts were available to examine than one pass examines; the rest go next tick, oldest first.
    public let capped: Bool?
    /// The carts this sweep touched, so a merchant can look at them before or after.
    public let cart_ids: [String]?
    /// The tenant baseline's window for CUSTOMER carts, in days. 0 is 'never delete' — the default, and also where an unparsable value lands, so no settings outage can start a purge.
    public let cart_ttl_days: Double?
    /// The baseline cutoff, for carts belonging to no market. Null when the baseline keeps everything.
    public let cutoff: String?
    /// Carts actually deleted. 0 on a dry run — see `found`.
    public let deleted: Int?
    /// Retention was in force for at least one cart this pass looked at — the baseline, or some market that sets a window while the baseline leaves it off. False means nothing could have been deleted.
    public let enabled: Bool?
    /// Carts past their retention window. On a dry run this is what the wet run would remove.
    public let found: Int?
    /// The same for GUEST carts — a cart with a session key and no contact behind it. Kept separate because the two are worth different amounts: a named B2B cart may be a quote somebody is still thinking about.
    public let guest_cart_ttl_days: Double?
    /// Lines actually deleted with them. 0 on a dry run.
    public let items_deleted: Int?
    /// The market codes this pass came across. Each cart was held against ITS market's window, not the baseline's.
    public let markets: [String]?
    /// Lines the wet run would remove. Always present, on a wet run too, so a client never has to tell "nothing to delete" apart from "this build did not report it".
    public let would_delete_items: Int?

    init(
        capped: Bool?,
        cart_ids: [String]?,
        cart_ttl_days: Double?,
        cutoff: String?,
        deleted: Int?,
        enabled: Bool?,
        found: Int?,
        guest_cart_ttl_days: Double?,
        items_deleted: Int?,
        markets: [String]?,
        would_delete_items: Int?
    ) {
        self.capped = capped
        self.cart_ids = cart_ids
        self.cart_ttl_days = cart_ttl_days
        self.cutoff = cutoff
        self.deleted = deleted
        self.enabled = enabled
        self.found = found
        self.guest_cart_ttl_days = guest_cart_ttl_days
        self.items_deleted = items_deleted
        self.markets = markets
        self.would_delete_items = would_delete_items
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.capped = try container.decodeIfPresent(Bool.self, forKey: .capped)
        self.cart_ids = try container.decodeIfPresent([String].self, forKey: .cart_ids)
        self.cart_ttl_days = try container.decodeIfPresent(Double.self, forKey: .cart_ttl_days)
        self.cutoff = try container.decodeIfPresent(String.self, forKey: .cutoff)
        self.deleted = try container.decodeIfPresent(Int.self, forKey: .deleted)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.found = try container.decodeIfPresent(Int.self, forKey: .found)
        self.guest_cart_ttl_days = try container.decodeIfPresent(Double.self, forKey: .guest_cart_ttl_days)
        self.items_deleted = try container.decodeIfPresent(Int.self, forKey: .items_deleted)
        self.markets = try container.decodeIfPresent([String].self, forKey: .markets)
        self.would_delete_items = try container.decodeIfPresent(Int.self, forKey: .would_delete_items)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(capped, forKey: .capped)
        try container.encodeIfPresent(cart_ids, forKey: .cart_ids)
        try container.encodeIfPresent(cart_ttl_days, forKey: .cart_ttl_days)
        try container.encodeIfPresent(cutoff, forKey: .cutoff)
        try container.encodeIfPresent(deleted, forKey: .deleted)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(found, forKey: .found)
        try container.encodeIfPresent(guest_cart_ttl_days, forKey: .guest_cart_ttl_days)
        try container.encodeIfPresent(items_deleted, forKey: .items_deleted)
        try container.encodeIfPresent(markets, forKey: .markets)
        try container.encodeIfPresent(would_delete_items, forKey: .would_delete_items)
    }

    public func toMap() -> [String: Any] {
        return [
            "capped": capped as Any,
            "cart_ids": cart_ids as Any,
            "cart_ttl_days": cart_ttl_days as Any,
            "cutoff": cutoff as Any,
            "deleted": deleted as Any,
            "enabled": enabled as Any,
            "found": found as Any,
            "guest_cart_ttl_days": guest_cart_ttl_days as Any,
            "items_deleted": items_deleted as Any,
            "markets": markets as Any,
            "would_delete_items": would_delete_items as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartPurgeSweep {
        return CartPurgeSweep(
            capped: map["capped"] as? Bool,
            cart_ids: map["cart_ids"] as? [String],
            cart_ttl_days: map["cart_ttl_days"] as? Double,
            cutoff: map["cutoff"] as? String,
            deleted: map["deleted"] as? Int,
            enabled: map["enabled"] as? Bool,
            found: map["found"] as? Int,
            guest_cart_ttl_days: map["guest_cart_ttl_days"] as? Double,
            items_deleted: map["items_deleted"] as? Int,
            markets: map["markets"] as? [String],
            would_delete_items: map["would_delete_items"] as? Int
        )
    }
}
