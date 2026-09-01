import Foundation
import JSONCodable

/// Columns List
open class ColumnList: Codable {

    enum CodingKeys: String, CodingKey {
        case columns = "columns"
        case total = "total"
    }

    /// List of columns.
    public let columns: [AnyCodable]
    /// Total number of columns in the given table.
    public let total: Int

    init(
        columns: [AnyCodable],
        total: Int
    ) {
        self.columns = columns
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.columns = try container.decode([AnyCodable].self, forKey: .columns)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(columns, forKey: .columns)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "columns": columns as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ColumnList {
        return ColumnList(
            columns: (map["columns"] as! [Any]).map { AnyCodable($0) },
            total: map["total"] as! Int
        )
    }
}
