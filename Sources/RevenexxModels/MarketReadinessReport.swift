import Foundation
import JSONCodable

/// Can this market actually trade? `ready` is false only when a BLOCKING check failed — no currency to quote in, no tax class to tax with. Warnings are degraded-but-serviceable. The market it is about, what it is made of, and the verdict — the readiness block is inlined here rather than nested, so this is MarketReadiness plus two keys.
open class MarketReadinessReport: Codable {

    enum CodingKeys: String, CodingKey {
        case blocking = "blocking"
        case checks = "checks"
        case counts = "counts"
        case market = "market"
        case ready = "ready"
        case serving = "serving"
        case warnings = "warnings"
    }

    /// Ids of the checks that failed BLOCKING — the market cannot do the job at all until each is fixed. Empty exactly when `ready` is true.
    public let blocking: [String]?
    /// Every check that ran, passed or failed, in a fixed order: locales, currencies, tax_classes, tax_basis. `blocking` and `warnings` are the failures from this list by id; this is where the reason lives.
    public let checks: [MarketReadinessCheck]?
    /// How much of a market this market actually is. All three at zero is a market that is a row and nothing else — the state two of the three live markets on the platform were left in, and the reason /clone and /backfill exist.
    public let counts: MarketReadinessCounts?
    /// The market the verdict is about, identified rather than returned in full — the five columns a reader needs to know which market answered. Read GET /markets/{id} for the rest.
    public let market: MarketReadinessSubject?
    /// `blocking` is empty. Deliberately not "every check passed": a market with one locale and no default flag on it is serviceable, and a verdict that cried wolf about that would be ignored on the day it mattered.
    public let ready: Bool?
    /// true when the market's status is 'active'. An active market that is not ready is live and broken — that combination is the one worth an alert.
    public let serving: Bool?
    /// Ids of the checks that failed as WARNINGS — degraded but serviceable, because something else covers for them. A missing locale is only a warning while the tenant declares a fallback_locale.
    public let warnings: [String]?

    init(
        blocking: [String]?,
        checks: [MarketReadinessCheck]?,
        counts: MarketReadinessCounts?,
        market: MarketReadinessSubject?,
        ready: Bool?,
        serving: Bool?,
        warnings: [String]?
    ) {
        self.blocking = blocking
        self.checks = checks
        self.counts = counts
        self.market = market
        self.ready = ready
        self.serving = serving
        self.warnings = warnings
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.blocking = try container.decodeIfPresent([String].self, forKey: .blocking)
        self.checks = try container.decodeIfPresent([MarketReadinessCheck].self, forKey: .checks)
        self.counts = try container.decodeIfPresent(MarketReadinessCounts.self, forKey: .counts)
        self.market = try container.decodeIfPresent(MarketReadinessSubject.self, forKey: .market)
        self.ready = try container.decodeIfPresent(Bool.self, forKey: .ready)
        self.serving = try container.decodeIfPresent(Bool.self, forKey: .serving)
        self.warnings = try container.decodeIfPresent([String].self, forKey: .warnings)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(blocking, forKey: .blocking)
        try container.encodeIfPresent(checks, forKey: .checks)
        try container.encodeIfPresent(counts, forKey: .counts)
        try container.encodeIfPresent(market, forKey: .market)
        try container.encodeIfPresent(ready, forKey: .ready)
        try container.encodeIfPresent(serving, forKey: .serving)
        try container.encodeIfPresent(warnings, forKey: .warnings)
    }

    public func toMap() -> [String: Any] {
        return [
            "blocking": blocking as Any,
            "checks": checks?.map { $0.toMap() } as Any,
            "counts": counts?.toMap() as Any,
            "market": market?.toMap() as Any,
            "ready": ready as Any,
            "serving": serving as Any,
            "warnings": warnings as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketReadinessReport {
        return MarketReadinessReport(
            blocking: map["blocking"] as? [String],
            checks: (map["checks"] as? [[String: Any]] ?? []).map { MarketReadinessCheck.from(map: $0) },
            counts: MarketReadinessCounts.from(map: map["counts"] as! [String: Any]),
            market: MarketReadinessSubject.from(map: map["market"] as! [String: Any]),
            ready: map["ready"] as? Bool,
            serving: map["serving"] as? Bool,
            warnings: map["warnings"] as? [String]
        )
    }
}
