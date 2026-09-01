import Foundation
import JSONCodable

/// Logs List
open class LogList: Codable {

    enum CodingKeys: String, CodingKey {
        case logs = "logs"
        case total = "total"
    }

    /// List of logs.
    public let logs: [Log]
    /// Total number of logs that matched your query.
    public let total: Int

    init(
        logs: [Log],
        total: Int
    ) {
        self.logs = logs
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.logs = try container.decode([Log].self, forKey: .logs)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(logs, forKey: .logs)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "logs": logs.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LogList {
        return LogList(
            logs: (map["logs"] as! [[String: Any]]).map { Log.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
