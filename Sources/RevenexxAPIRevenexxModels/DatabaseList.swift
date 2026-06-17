import Foundation
import JSONCodable

/// Databases List
open class DatabaseList: Codable {

    enum CodingKeys: String, CodingKey {
        case databases = "databases"
        case total = "total"
    }

    /// List of databases.
    public let databases: [Database]
    /// Total number of databases that matched your query.
    public let total: Int

    init(
        databases: [Database],
        total: Int
    ) {
        self.databases = databases
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.databases = try container.decode([Database].self, forKey: .databases)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(databases, forKey: .databases)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "databases": databases.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> DatabaseList {
        return DatabaseList(
            databases: (map["databases"] as! [[String: Any]]).map { Database.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
