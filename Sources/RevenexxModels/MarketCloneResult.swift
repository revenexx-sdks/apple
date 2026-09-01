import Foundation
import JSONCodable

/// What was built. `copied` and `seeded` account for every child row that now exists, and `readiness` is the verdict on the result — so the call that made the market also tells you whether it finished the job.
open class MarketCloneResult: Codable {

    enum CodingKeys: String, CodingKey {
        case copied = "copied"
        case market = "market"
        case readiness = "readiness"
        case seeded = "seeded"
        case source = "source"
    }

    /// Child rows copied from the source, per collection. A flag left false is a zero here, and so is a source that had none of that kind.
    public let copied: MarketCloneCopied?
    /// A distinct business context within a tenant — a country, a region, or a storefront segment such as B2C vs B2B — with its own base currency, locales, traded currencies and tax classes. A market is also the platform's `market` SCOPE dimension: every other commerce app slices its data by one, keyed on this row's `code`. A market is never just this row: it needs at least one locale, one currency and one tax class before it can serve, which is what /readiness measures and what /clone and /backfill build.
    public let market: Market?
    /// Can this market actually trade? `ready` is false only when a BLOCKING check failed — no currency to quote in, no tax class to tax with. Warnings are degraded-but-serviceable.
    public let readiness: MarketReadiness?
    /// Rows this call added that were copied from nowhere, because the new market would otherwise have been left unable to trade: the tenant `fallback_locale` when neither market had a locale, and the base currency when it is not in the copied set. Zero on both is the normal, healthy answer — it means nothing had to be invented.
    public let seeded: MarketCloneSeeded?
    /// The market that was read from, resolved — so a caller who passed a code back gets the uuid, and one who passed a uuid gets the code the rest of the platform stores.
    public let source: MarketRef?

    init(
        copied: MarketCloneCopied?,
        market: Market?,
        readiness: MarketReadiness?,
        seeded: MarketCloneSeeded?,
        source: MarketRef?
    ) {
        self.copied = copied
        self.market = market
        self.readiness = readiness
        self.seeded = seeded
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.copied = try container.decodeIfPresent(MarketCloneCopied.self, forKey: .copied)
        self.market = try container.decodeIfPresent(Market.self, forKey: .market)
        self.readiness = try container.decodeIfPresent(MarketReadiness.self, forKey: .readiness)
        self.seeded = try container.decodeIfPresent(MarketCloneSeeded.self, forKey: .seeded)
        self.source = try container.decodeIfPresent(MarketRef.self, forKey: .source)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(copied, forKey: .copied)
        try container.encodeIfPresent(market, forKey: .market)
        try container.encodeIfPresent(readiness, forKey: .readiness)
        try container.encodeIfPresent(seeded, forKey: .seeded)
        try container.encodeIfPresent(source, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "copied": copied?.toMap() as Any,
            "market": market?.toMap() as Any,
            "readiness": readiness?.toMap() as Any,
            "seeded": seeded?.toMap() as Any,
            "source": source?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCloneResult {
        return MarketCloneResult(
            copied: MarketCloneCopied.from(map: map["copied"] as! [String: Any]),
            market: Market.from(map: map["market"] as! [String: Any]),
            readiness: MarketReadiness.from(map: map["readiness"] as! [String: Any]),
            seeded: MarketCloneSeeded.from(map: map["seeded"] as! [String: Any]),
            source: MarketRef.from(map: map["source"] as! [String: Any])
        )
    }
}
