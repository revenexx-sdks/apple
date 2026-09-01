import Foundation
import JSONCodable

/// Can this market actually trade? `ready` is false only when a BLOCKING check failed — no currency to quote in, no tax class to tax with. Warnings are degraded-but-serviceable.
open class MarketReadiness: Codable {

    enum CodingKeys: String, CodingKey {
        case blocking = "blocking"
        case checks = "checks"
        case ready = "ready"
        case serving = "serving"
        case warnings = "warnings"
    }

    /// Ids of the checks that failed BLOCKING — the market cannot do the job at all until each is fixed. Empty exactly when `ready` is true.
    public let blocking: [String]?
    /// Every check that ran, passed or failed, in a fixed order: locales, currencies, tax_classes, tax_basis. `blocking` and `warnings` are the failures from this list by id; this is where the reason lives.
    public let checks: [MarketReadinessCheck]?
    /// `blocking` is empty. Deliberately not "every check passed": a market with one locale and no default flag on it is serviceable, and a verdict that cried wolf about that would be ignored on the day it mattered.
    public let ready: Bool?
    /// true when the market's status is 'active'. An active market that is not ready is live and broken — that combination is the one worth an alert.
    public let serving: Bool?
    /// Ids of the checks that failed as WARNINGS — degraded but serviceable, because something else covers for them. A missing locale is only a warning while the tenant declares a fallback_locale.
    public let warnings: [String]?

    init(
        blocking: [String]?,
        checks: [MarketReadinessCheck]?,
        ready: Bool?,
        serving: Bool?,
        warnings: [String]?
    ) {
        self.blocking = blocking
        self.checks = checks
        self.ready = ready
        self.serving = serving
        self.warnings = warnings
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.blocking = try container.decodeIfPresent([String].self, forKey: .blocking)
        self.checks = try container.decodeIfPresent([MarketReadinessCheck].self, forKey: .checks)
        self.ready = try container.decodeIfPresent(Bool.self, forKey: .ready)
        self.serving = try container.decodeIfPresent(Bool.self, forKey: .serving)
        self.warnings = try container.decodeIfPresent([String].self, forKey: .warnings)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(blocking, forKey: .blocking)
        try container.encodeIfPresent(checks, forKey: .checks)
        try container.encodeIfPresent(ready, forKey: .ready)
        try container.encodeIfPresent(serving, forKey: .serving)
        try container.encodeIfPresent(warnings, forKey: .warnings)
    }

    public func toMap() -> [String: Any] {
        return [
            "blocking": blocking as Any,
            "checks": checks?.map { $0.toMap() } as Any,
            "ready": ready as Any,
            "serving": serving as Any,
            "warnings": warnings as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketReadiness {
        return MarketReadiness(
            blocking: map["blocking"] as? [String],
            checks: (map["checks"] as? [[String: Any]] ?? []).map { MarketReadinessCheck.from(map: $0) },
            ready: map["ready"] as? Bool,
            serving: map["serving"] as? Bool,
            warnings: map["warnings"] as? [String]
        )
    }
}
