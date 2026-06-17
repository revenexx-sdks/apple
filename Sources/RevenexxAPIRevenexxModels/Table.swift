import Foundation
import JSONCodable

/// Table
open class Table: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case permissions = "$permissions"
        case updatedAt = "$updatedAt"
        case bytesMax = "bytesMax"
        case bytesUsed = "bytesUsed"
        case columns = "columns"
        case databaseId = "databaseId"
        case enabled = "enabled"
        case indexes = "indexes"
        case name = "name"
        case rowSecurity = "rowSecurity"
    }

    /// Table creation date in ISO 8601 format.
    public let createdAt: String
    /// Table ID.
    public let id: String
    /// Table permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
    public let permissions: [String]
    /// Table update date in ISO 8601 format.
    public let updatedAt: String
    /// Maximum row size in bytes. Returns 0 when no limit applies.
    public let bytesMax: Int
    /// Currently used row size in bytes based on defined columns.
    public let bytesUsed: Int
    /// Table columns.
    public let columns: [AnyCodable]
    /// Database ID.
    public let databaseId: String
    /// Table enabled. Can be &#039;enabled&#039; or &#039;disabled&#039;. When disabled, the table is inaccessible to users, but remains accessible to Server SDKs using API keys.
    public let enabled: Bool
    /// Table indexes.
    public let indexes: [ColumnIndex]
    /// Table name.
    public let name: String
    /// Whether row-level permissions are enabled. [Learn more about permissions](https://appwrite.io/docs/permissions).
    public let rowSecurity: Bool

    init(
        createdAt: String,
        id: String,
        permissions: [String],
        updatedAt: String,
        bytesMax: Int,
        bytesUsed: Int,
        columns: [AnyCodable],
        databaseId: String,
        enabled: Bool,
        indexes: [ColumnIndex],
        name: String,
        rowSecurity: Bool
    ) {
        self.createdAt = createdAt
        self.id = id
        self.permissions = permissions
        self.updatedAt = updatedAt
        self.bytesMax = bytesMax
        self.bytesUsed = bytesUsed
        self.columns = columns
        self.databaseId = databaseId
        self.enabled = enabled
        self.indexes = indexes
        self.name = name
        self.rowSecurity = rowSecurity
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.bytesMax = try container.decode(Int.self, forKey: .bytesMax)
        self.bytesUsed = try container.decode(Int.self, forKey: .bytesUsed)
        self.columns = try container.decode([AnyCodable].self, forKey: .columns)
        self.databaseId = try container.decode(String.self, forKey: .databaseId)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.indexes = try container.decode([ColumnIndex].self, forKey: .indexes)
        self.name = try container.decode(String.self, forKey: .name)
        self.rowSecurity = try container.decode(Bool.self, forKey: .rowSecurity)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(bytesMax, forKey: .bytesMax)
        try container.encode(bytesUsed, forKey: .bytesUsed)
        try container.encode(columns, forKey: .columns)
        try container.encode(databaseId, forKey: .databaseId)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(indexes, forKey: .indexes)
        try container.encode(name, forKey: .name)
        try container.encode(rowSecurity, forKey: .rowSecurity)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$permissions": permissions as Any,
            "$updatedAt": updatedAt as Any,
            "bytesMax": bytesMax as Any,
            "bytesUsed": bytesUsed as Any,
            "columns": columns as Any,
            "databaseId": databaseId as Any,
            "enabled": enabled as Any,
            "indexes": indexes.map { $0.toMap() } as Any,
            "name": name as Any,
            "rowSecurity": rowSecurity as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Table {
        return Table(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            permissions: map["$permissions"] as! [String],
            updatedAt: map["$updatedAt"] as! String,
            bytesMax: map["bytesMax"] as! Int,
            bytesUsed: map["bytesUsed"] as! Int,
            columns: (map["columns"] as! [Any]).map { AnyCodable($0) },
            databaseId: map["databaseId"] as! String,
            enabled: map["enabled"] as! Bool,
            indexes: (map["indexes"] as! [[String: Any]]).map { ColumnIndex.from(map: $0) },
            name: map["name"] as! String,
            rowSecurity: map["rowSecurity"] as! Bool
        )
    }
}
