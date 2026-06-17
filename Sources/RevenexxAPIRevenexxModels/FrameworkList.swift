import Foundation
import JSONCodable

/// Frameworks List
open class FrameworkList: Codable {

    enum CodingKeys: String, CodingKey {
        case frameworks = "frameworks"
        case total = "total"
    }

    /// List of frameworks.
    public let frameworks: [Framework]
    /// Total number of frameworks that matched your query.
    public let total: Int

    init(
        frameworks: [Framework],
        total: Int
    ) {
        self.frameworks = frameworks
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.frameworks = try container.decode([Framework].self, forKey: .frameworks)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(frameworks, forKey: .frameworks)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "frameworks": frameworks.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FrameworkList {
        return FrameworkList(
            frameworks: (map["frameworks"] as! [[String: Any]]).map { Framework.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
