import Foundation
import JSONCodable

/// Rows List
open class RowList<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case rows = "rows"
        case total = "total"
    }

    /// List of rows.
    public let rows: [Row<T>]
    /// Total number of rows that matched your query.
    public let total: Int

    init(
        rows: [Row<T>],
        total: Int
    ) {
        self.rows = rows
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.rows = try container.decode([Row<T>].self, forKey: .rows)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(rows, forKey: .rows)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "rows": rows.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> RowList {
        return RowList(
            rows: (map["rows"] as! [[String: Any]]).map { Row.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
