import Foundation
import JSONCodable

/// 
open class CartMaintenanceResult: Codable {

    enum CodingKeys: String, CodingKey {
        case abandon = "abandon"
        case dry_run = "dry_run"
        case purge = "purge"
        case swept_at = "swept_at"
    }

    /// The first sweep: active carts nobody has touched since their market's window become abandoned. Nothing else in the platform ever stamps abandoned_at, so without this the abandonment funnel is empty by construction rather than empty because nobody abandons carts.
    public let abandon: CartAbandonSweep?
    /// This pass wrote nothing. The counts and cart ids are the same ones the wet run would produce.
    public let dry_run: Bool?
    /// The second sweep, and the only destructive thing this app does: carts past their retention window are deleted, their lines with them. An ordered cart is never touched at any setting — it is the source record of a sale.
    public let purge: CartPurgeSweep?
    /// The instant this pass measured every window against. One clock for both sweeps, so a cart cannot be judged idle by one and fresh by the other.
    public let swept_at: String?

    init(
        abandon: CartAbandonSweep?,
        dry_run: Bool?,
        purge: CartPurgeSweep?,
        swept_at: String?
    ) {
        self.abandon = abandon
        self.dry_run = dry_run
        self.purge = purge
        self.swept_at = swept_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.abandon = try container.decodeIfPresent(CartAbandonSweep.self, forKey: .abandon)
        self.dry_run = try container.decodeIfPresent(Bool.self, forKey: .dry_run)
        self.purge = try container.decodeIfPresent(CartPurgeSweep.self, forKey: .purge)
        self.swept_at = try container.decodeIfPresent(String.self, forKey: .swept_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(abandon, forKey: .abandon)
        try container.encodeIfPresent(dry_run, forKey: .dry_run)
        try container.encodeIfPresent(purge, forKey: .purge)
        try container.encodeIfPresent(swept_at, forKey: .swept_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "abandon": abandon?.toMap() as Any,
            "dry_run": dry_run as Any,
            "purge": purge?.toMap() as Any,
            "swept_at": swept_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartMaintenanceResult {
        return CartMaintenanceResult(
            abandon: CartAbandonSweep.from(map: map["abandon"] as! [String: Any]),
            dry_run: map["dry_run"] as? Bool,
            purge: CartPurgeSweep.from(map: map["purge"] as! [String: Any]),
            swept_at: map["swept_at"] as? String
        )
    }
}
