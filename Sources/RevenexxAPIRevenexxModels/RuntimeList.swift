import Foundation
import JSONCodable

/// Runtimes List
open class RuntimeList: Codable {

    enum CodingKeys: String, CodingKey {
        case runtimes = "runtimes"
        case total = "total"
    }

    /// List of runtimes.
    public let runtimes: [Runtime]
    /// Total number of runtimes that matched your query.
    public let total: Int

    init(
        runtimes: [Runtime],
        total: Int
    ) {
        self.runtimes = runtimes
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.runtimes = try container.decode([Runtime].self, forKey: .runtimes)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(runtimes, forKey: .runtimes)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "runtimes": runtimes.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> RuntimeList {
        return RuntimeList(
            runtimes: (map["runtimes"] as! [[String: Any]]).map { Runtime.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
