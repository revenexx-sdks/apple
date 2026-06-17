import Foundation
import JSONCodable

/// Row
open class Row<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case databaseId = "$databaseId"
        case id = "$id"
        case permissions = "$permissions"
        case sequence = "$sequence"
        case tableId = "$tableId"
        case updatedAt = "$updatedAt"
        case data
    }

    /// Row creation date in ISO 8601 format.
    public let createdAt: String
    /// Database ID.
    public let databaseId: String
    /// Row ID.
    public let id: String
    /// Row permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
    public let permissions: [String]
    /// Row automatically incrementing ID.
    public let sequence: Int
    /// Table ID.
    public let tableId: String
    /// Row update date in ISO 8601 format.
    public let updatedAt: String
    /// Additional properties
    public let data: T

    init(
        createdAt: String,
        databaseId: String,
        id: String,
        permissions: [String],
        sequence: Int,
        tableId: String,
        updatedAt: String,
        data: T
    ) {
        self.createdAt = createdAt
        self.databaseId = databaseId
        self.id = id
        self.permissions = permissions
        self.sequence = sequence
        self.tableId = tableId
        self.updatedAt = updatedAt
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.databaseId = try container.decode(String.self, forKey: .databaseId)
        self.id = try container.decode(String.self, forKey: .id)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.sequence = try container.decode(Int.self, forKey: .sequence)
        self.tableId = try container.decode(String.self, forKey: .tableId)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(databaseId, forKey: .databaseId)
        try container.encode(id, forKey: .id)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(sequence, forKey: .sequence)
        try container.encode(tableId, forKey: .tableId)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$databaseId": databaseId as Any,
            "$id": id as Any,
            "$permissions": permissions as Any,
            "$sequence": sequence as Any,
            "$tableId": tableId as Any,
            "$updatedAt": updatedAt as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> Row {
        return Row(
            createdAt: map["$createdAt"] as! String,
            databaseId: map["$databaseId"] as! String,
            id: map["$id"] as! String,
            permissions: map["$permissions"] as! [String],
            sequence: map["$sequence"] as! Int,
            tableId: map["$tableId"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
