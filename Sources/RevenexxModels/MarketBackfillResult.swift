import Foundation
import JSONCodable

/// What the repair changed. `kept` + `added` + `seeded` is what the market now holds, and separating them is the point: it shows that nothing the merchant had already decided was touched.
open class MarketBackfillResult: Codable {

    enum CodingKeys: String, CodingKey {
        case added = "added"
        case kept = "kept"
        case market = "market"
        case readiness = "readiness"
        case seeded = "seeded"
        case source = "source"
    }

    /// Child rows copied in from the source, per collection — only codes this market did not already carry. Zero everywhere on a second run: the call is idempotent.
    public let added: MarketBackfillAdded?
    /// What this market already held BEFORE the repair, per collection — the rows that were left exactly as the merchant left them.
    public let kept: MarketBackfillKept?
    /// A distinct business context within a tenant — a country, a region, or a storefront segment such as B2C vs B2B — with its own base currency, locales, traded currencies and tax classes. A market is also the platform's `market` SCOPE dimension: every other commerce app slices its data by one, keyed on this row's `code`. A market is never just this row: it needs at least one locale, one currency and one tax class before it can serve, which is what /readiness measures and what /clone and /backfill build.
    public let market: Market?
    /// Can this market actually trade? `ready` is false only when a BLOCKING check failed — no currency to quote in, no tax class to tax with. Warnings are degraded-but-serviceable.
    public let readiness: MarketReadiness?
    /// Rows this call added that were copied from nowhere, because the new market would otherwise have been left unable to trade: the tenant `fallback_locale` when neither market had a locale, and the base currency when it is not in the copied set. Zero on both is the normal, healthy answer — it means nothing had to be invented.
    public let seeded: MarketBackfillSeeded?
    /// The market that was read from, resolved — so a caller who passed a code back gets the uuid, and one who passed a uuid gets the code the rest of the platform stores.
    public let source: MarketRef?

    init(
        added: MarketBackfillAdded?,
        kept: MarketBackfillKept?,
        market: Market?,
        readiness: MarketReadiness?,
        seeded: MarketBackfillSeeded?,
        source: MarketRef?
    ) {
        self.added = added
        self.kept = kept
        self.market = market
        self.readiness = readiness
        self.seeded = seeded
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.added = try container.decodeIfPresent(MarketBackfillAdded.self, forKey: .added)
        self.kept = try container.decodeIfPresent(MarketBackfillKept.self, forKey: .kept)
        self.market = try container.decodeIfPresent(Market.self, forKey: .market)
        self.readiness = try container.decodeIfPresent(MarketReadiness.self, forKey: .readiness)
        self.seeded = try container.decodeIfPresent(MarketBackfillSeeded.self, forKey: .seeded)
        self.source = try container.decodeIfPresent(MarketRef.self, forKey: .source)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(added, forKey: .added)
        try container.encodeIfPresent(kept, forKey: .kept)
        try container.encodeIfPresent(market, forKey: .market)
        try container.encodeIfPresent(readiness, forKey: .readiness)
        try container.encodeIfPresent(seeded, forKey: .seeded)
        try container.encodeIfPresent(source, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "added": added?.toMap() as Any,
            "kept": kept?.toMap() as Any,
            "market": market?.toMap() as Any,
            "readiness": readiness?.toMap() as Any,
            "seeded": seeded?.toMap() as Any,
            "source": source?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketBackfillResult {
        return MarketBackfillResult(
            added: MarketBackfillAdded.from(map: map["added"] as! [String: Any]),
            kept: MarketBackfillKept.from(map: map["kept"] as! [String: Any]),
            market: Market.from(map: map["market"] as! [String: Any]),
            readiness: MarketReadiness.from(map: map["readiness"] as! [String: Any]),
            seeded: MarketBackfillSeeded.from(map: map["seeded"] as! [String: Any]),
            source: MarketRef.from(map: map["source"] as! [String: Any])
        )
    }
}
