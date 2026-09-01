import Foundation
import JSONCodable

/// 
open class ReorderAlerts: Codable {

    enum CodingKeys: String, CodingKey {
        case alerts = "alerts"
        case enabled = "enabled"
        case reorder_point_default = "reorder_point_default"
    }

    /// The rows at or below their reorder point, worst first (by `shortfall`). Computed on read, so it is never stale — and never empty because of caching: an empty list means nothing is low, unless `enabled` is false.
    public let alerts: [ReorderAlert]?
    /// false when reorder_alert_enabled is off — the list is then empty by policy, not because nothing is low.
    public let enabled: Bool?
    /// The threshold applied to rows carrying none of their own.
    public let reorder_point_default: Double?

    init(
        alerts: [ReorderAlert]?,
        enabled: Bool?,
        reorder_point_default: Double?
    ) {
        self.alerts = alerts
        self.enabled = enabled
        self.reorder_point_default = reorder_point_default
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.alerts = try container.decodeIfPresent([ReorderAlert].self, forKey: .alerts)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.reorder_point_default = try container.decodeIfPresent(Double.self, forKey: .reorder_point_default)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(alerts, forKey: .alerts)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(reorder_point_default, forKey: .reorder_point_default)
    }

    public func toMap() -> [String: Any] {
        return [
            "alerts": alerts?.map { $0.toMap() } as Any,
            "enabled": enabled as Any,
            "reorder_point_default": reorder_point_default as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReorderAlerts {
        return ReorderAlerts(
            alerts: (map["alerts"] as? [[String: Any]] ?? []).map { ReorderAlert.from(map: $0) },
            enabled: map["enabled"] as? Bool,
            reorder_point_default: map["reorder_point_default"] as? Double
        )
    }
}
