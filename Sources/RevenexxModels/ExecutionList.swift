import Foundation
import JSONCodable

/// Executions List
open class ExecutionList: Codable {

    enum CodingKeys: String, CodingKey {
        case executions = "executions"
        case total = "total"
    }

    /// List of executions.
    public let executions: [Execution]
    /// Total number of executions that matched your query.
    public let total: Int

    init(
        executions: [Execution],
        total: Int
    ) {
        self.executions = executions
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.executions = try container.decode([Execution].self, forKey: .executions)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(executions, forKey: .executions)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "executions": executions.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ExecutionList {
        return ExecutionList(
            executions: (map["executions"] as! [[String: Any]]).map { Execution.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
