import Foundation
import JSONCodable

/// Status List
open class HealthStatusList: Codable {

    enum CodingKeys: String, CodingKey {
        case statuses = "statuses"
        case total = "total"
    }

    /// List of statuses.
    public let statuses: [HealthStatus]
    /// Total number of statuses that matched your query.
    public let total: Int

    init(
        statuses: [HealthStatus],
        total: Int
    ) {
        self.statuses = statuses
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.statuses = try container.decode([HealthStatus].self, forKey: .statuses)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(statuses, forKey: .statuses)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "statuses": statuses.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> HealthStatusList {
        return HealthStatusList(
            statuses: (map["statuses"] as! [[String: Any]]).map { HealthStatus.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
