import Foundation
import JSONCodable

/// 
open class ReservationSweepResult: Codable {

    enum CodingKeys: String, CodingKey {
        case expired = "expired"
        case markets = "markets"
        case released = "released"
        case swept_at = "swept_at"
        case ttl_minutes = "ttl_minutes"
    }

    /// How many active reservations were found past their hold: the ones with an `expires_at` in the past, plus the undated ones older than their market's TTL.
    public let expired: Int?
    /// The market codes this run had to resolve a window for — every market that had an undated active reservation. Empty when nothing is market-assigned, which is the usual case.
    public let markets: [String]?
    /// How many were actually given back — `reserved` lowered on the stock row and a `release` booking written for each. It equals `expired` unless a row vanished mid-run. Idempotent: a second run immediately after finds nothing and answers 0.
    public let released: Int?
    /// The cut-off this run used — everything whose hold had run out by this moment was released. It is the run's own clock, not a stored value.
    public let swept_at: String?
    /// The `reservation_ttl_minutes` that applied to reservations belonging to NO market — the tenant baseline. A reservation assigned to a market is judged against that market's own window instead, which is why this is reported rather than assumed to be the only one.
    public let ttl_minutes: Double?

    init(
        expired: Int?,
        markets: [String]?,
        released: Int?,
        swept_at: String?,
        ttl_minutes: Double?
    ) {
        self.expired = expired
        self.markets = markets
        self.released = released
        self.swept_at = swept_at
        self.ttl_minutes = ttl_minutes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.expired = try container.decodeIfPresent(Int.self, forKey: .expired)
        self.markets = try container.decodeIfPresent([String].self, forKey: .markets)
        self.released = try container.decodeIfPresent(Int.self, forKey: .released)
        self.swept_at = try container.decodeIfPresent(String.self, forKey: .swept_at)
        self.ttl_minutes = try container.decodeIfPresent(Double.self, forKey: .ttl_minutes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(expired, forKey: .expired)
        try container.encodeIfPresent(markets, forKey: .markets)
        try container.encodeIfPresent(released, forKey: .released)
        try container.encodeIfPresent(swept_at, forKey: .swept_at)
        try container.encodeIfPresent(ttl_minutes, forKey: .ttl_minutes)
    }

    public func toMap() -> [String: Any] {
        return [
            "expired": expired as Any,
            "markets": markets as Any,
            "released": released as Any,
            "swept_at": swept_at as Any,
            "ttl_minutes": ttl_minutes as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReservationSweepResult {
        return ReservationSweepResult(
            expired: map["expired"] as? Int,
            markets: map["markets"] as? [String],
            released: map["released"] as? Int,
            swept_at: map["swept_at"] as? String,
            ttl_minutes: map["ttl_minutes"] as? Double
        )
    }
}
