import Foundation
import JSONCodable

/// The delivery window a checkout can print. Calendar days, cut-off evaluated in UTC (send `at` to control the instant).
open class ShippingDeliveryEstimate: Codable {

    enum CodingKeys: String, CodingKey {
        case cutoff_passed = "cutoff_passed"
        case cutoff_time = "cutoff_time"
        case earliest = "earliest"
        case handling_days = "handling_days"
        case latest = "latest"
        case ship_date = "ship_date"
    }

    /// Whether the cut-off had passed at evaluation time, costing a day.
    public let cutoff_passed: Bool?
    /// The cut-off applied (HH:MM, UTC), or null when none is configured — the carrier's own when it declares one, else the market's `cutoff_time` setting.
    public let cutoff_time: String?
    /// ship_date + eta_days_min.
    public let earliest: String?
    /// The tenant's handling_days setting, as applied.
    public let handling_days: Int?
    /// ship_date + eta_days_max.
    public let latest: String?
    /// The day the parcel leaves — today plus handling days, plus one when the cut-off has passed.
    public let ship_date: String?

    init(
        cutoff_passed: Bool?,
        cutoff_time: String?,
        earliest: String?,
        handling_days: Int?,
        latest: String?,
        ship_date: String?
    ) {
        self.cutoff_passed = cutoff_passed
        self.cutoff_time = cutoff_time
        self.earliest = earliest
        self.handling_days = handling_days
        self.latest = latest
        self.ship_date = ship_date
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.cutoff_passed = try container.decodeIfPresent(Bool.self, forKey: .cutoff_passed)
        self.cutoff_time = try container.decodeIfPresent(String.self, forKey: .cutoff_time)
        self.earliest = try container.decodeIfPresent(String.self, forKey: .earliest)
        self.handling_days = try container.decodeIfPresent(Int.self, forKey: .handling_days)
        self.latest = try container.decodeIfPresent(String.self, forKey: .latest)
        self.ship_date = try container.decodeIfPresent(String.self, forKey: .ship_date)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(cutoff_passed, forKey: .cutoff_passed)
        try container.encodeIfPresent(cutoff_time, forKey: .cutoff_time)
        try container.encodeIfPresent(earliest, forKey: .earliest)
        try container.encodeIfPresent(handling_days, forKey: .handling_days)
        try container.encodeIfPresent(latest, forKey: .latest)
        try container.encodeIfPresent(ship_date, forKey: .ship_date)
    }

    public func toMap() -> [String: Any] {
        return [
            "cutoff_passed": cutoff_passed as Any,
            "cutoff_time": cutoff_time as Any,
            "earliest": earliest as Any,
            "handling_days": handling_days as Any,
            "latest": latest as Any,
            "ship_date": ship_date as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingDeliveryEstimate {
        return ShippingDeliveryEstimate(
            cutoff_passed: map["cutoff_passed"] as? Bool,
            cutoff_time: map["cutoff_time"] as? String,
            earliest: map["earliest"] as? String,
            handling_days: map["handling_days"] as? Int,
            latest: map["latest"] as? String,
            ship_date: map["ship_date"] as? String
        )
    }
}
