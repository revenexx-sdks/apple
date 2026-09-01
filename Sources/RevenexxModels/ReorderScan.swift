import Foundation
import JSONCodable

/// 
open class ReorderScan: Codable {

    enum CodingKeys: String, CodingKey {
        case emitted = "emitted"
        case enabled = "enabled"
        case scanned = "scanned"
    }

    /// One entry per published event, in the order they went out. Re-running the scan on the same day returns the SAME ids and publishes nothing a second time — the event id is derived from the row and the day, and the bus drops the repeat.
    public let emitted: [ReorderScanEmit]
    /// false when reorder_alert_enabled is off — nothing was published, and not because nothing is low.
    public let enabled: Bool
    /// How many rows were at or below their point when the scan ran.
    public let scanned: Int

    init(
        emitted: [ReorderScanEmit],
        enabled: Bool,
        scanned: Int
    ) {
        self.emitted = emitted
        self.enabled = enabled
        self.scanned = scanned
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.emitted = try container.decode([ReorderScanEmit].self, forKey: .emitted)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.scanned = try container.decode(Int.self, forKey: .scanned)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(emitted, forKey: .emitted)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(scanned, forKey: .scanned)
    }

    public func toMap() -> [String: Any] {
        return [
            "emitted": emitted.map { $0.toMap() } as Any,
            "enabled": enabled as Any,
            "scanned": scanned as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReorderScan {
        return ReorderScan(
            emitted: (map["emitted"] as! [[String: Any]]).map { ReorderScanEmit.from(map: $0) },
            enabled: map["enabled"] as! Bool,
            scanned: map["scanned"] as! Int
        )
    }
}
