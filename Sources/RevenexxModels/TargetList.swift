import Foundation
import JSONCodable

/// Target list
open class TargetList: Codable {

    enum CodingKeys: String, CodingKey {
        case targets = "targets"
        case total = "total"
    }

    /// List of targets.
    public let targets: [Target]
    /// Total number of targets that matched your query.
    public let total: Int

    init(
        targets: [Target],
        total: Int
    ) {
        self.targets = targets
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.targets = try container.decode([Target].self, forKey: .targets)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(targets, forKey: .targets)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "targets": targets.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TargetList {
        return TargetList(
            targets: (map["targets"] as! [[String: Any]]).map { Target.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
