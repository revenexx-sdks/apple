import Foundation
import JSONCodable

/// Index
open class ColumnIndex: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case columns = "columns"
        case error = "error"
        case key = "key"
        case lengths = "lengths"
        case orders = "orders"
        case status = "status"
        case type = "type"
    }

    /// Index creation date in ISO 8601 format.
    public let createdAt: String
    /// Index ID.
    public let id: String
    /// Index update date in ISO 8601 format.
    public let updatedAt: String
    /// Index columns.
    public let columns: [String]
    /// Error message. Displays error generated on failure of creating or deleting an index.
    public let error: String
    /// Index Key.
    public let key: String
    /// Index columns length.
    public let lengths: [Int]
    /// Index orders.
    public let orders: [String]?
    /// Index status. Possible values: `available`, `processing`, `deleting`, `stuck`, or `failed`
    public let status: String
    /// Index type.
    public let type: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        columns: [String],
        error: String,
        key: String,
        lengths: [Int],
        orders: [String]?,
        status: String,
        type: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.columns = columns
        self.error = error
        self.key = key
        self.lengths = lengths
        self.orders = orders
        self.status = status
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.columns = try container.decode([String].self, forKey: .columns)
        self.error = try container.decode(String.self, forKey: .error)
        self.key = try container.decode(String.self, forKey: .key)
        self.lengths = try container.decode([Int].self, forKey: .lengths)
        self.orders = try container.decodeIfPresent([String].self, forKey: .orders)
        self.status = try container.decode(String.self, forKey: .status)
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(columns, forKey: .columns)
        try container.encode(error, forKey: .error)
        try container.encode(key, forKey: .key)
        try container.encode(lengths, forKey: .lengths)
        try container.encodeIfPresent(orders, forKey: .orders)
        try container.encode(status, forKey: .status)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "columns": columns as Any,
            "error": error as Any,
            "key": key as Any,
            "lengths": lengths as Any,
            "orders": orders as Any,
            "status": status as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ColumnIndex {
        return ColumnIndex(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            columns: map["columns"] as! [String],
            error: map["error"] as! String,
            key: map["key"] as! String,
            lengths: map["lengths"] as! [Int],
            orders: map["orders"] as? [String],
            status: map["status"] as! String,
            type: map["type"] as! String
        )
    }
}
