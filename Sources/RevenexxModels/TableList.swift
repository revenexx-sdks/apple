import Foundation
import JSONCodable

/// Tables List
open class TableList: Codable {

    enum CodingKeys: String, CodingKey {
        case tables = "tables"
        case total = "total"
    }

    /// List of tables.
    public let tables: [Table]
    /// Total number of tables that matched your query.
    public let total: Int

    init(
        tables: [Table],
        total: Int
    ) {
        self.tables = tables
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.tables = try container.decode([Table].self, forKey: .tables)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(tables, forKey: .tables)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "tables": tables.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TableList {
        return TableList(
            tables: (map["tables"] as! [[String: Any]]).map { Table.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
