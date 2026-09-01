import Foundation
import JSONCodable

/// The market as it now stands, plus what had to move out of its way.
open class MarketMakeDefaultResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case demoted = "demoted"
        case market = "market"
    }

    /// Codes of the markets that lost the flag. Empty when this market already held it — the call is idempotent and writes nothing on a repeat, so an empty array is a success, not a no-op that failed.
    public let demoted: [String]?
    /// A distinct business context within a tenant — a country, a region, or a storefront segment such as B2C vs B2B — with its own base currency, locales, traded currencies and tax classes. A market is also the platform's `market` SCOPE dimension: every other commerce app slices its data by one, keyed on this row's `code`. A market is never just this row: it needs at least one locale, one currency and one tax class before it can serve, which is what /readiness measures and what /clone and /backfill build.
    public let market: Market?

    init(
        demoted: [String]?,
        market: Market?
    ) {
        self.demoted = demoted
        self.market = market
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.demoted = try container.decodeIfPresent([String].self, forKey: .demoted)
        self.market = try container.decodeIfPresent(Market.self, forKey: .market)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(demoted, forKey: .demoted)
        try container.encodeIfPresent(market, forKey: .market)
    }

    public func toMap() -> [String: Any] {
        return [
            "demoted": demoted as Any,
            "market": market?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketMakeDefaultResponse {
        return MarketMakeDefaultResponse(
            demoted: map["demoted"] as? [String],
            market: Market.from(map: map["market"] as! [String: Any])
        )
    }
}
