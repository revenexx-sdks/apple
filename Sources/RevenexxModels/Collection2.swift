import Foundation
import JSONCodable

/// Collection
open class Collection2: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case permissions = "$permissions"
        case updatedAt = "$updatedAt"
        case attributes = "attributes"
        case bytesMax = "bytesMax"
        case bytesUsed = "bytesUsed"
        case databaseId = "databaseId"
        case documentSecurity = "documentSecurity"
        case enabled = "enabled"
        case indexes = "indexes"
        case name = "name"
    }

    /// Collection creation date in ISO 8601 format.
    public let createdAt: String
    /// Collection ID.
    public let id: String
    /// Collection permissions. Each entry is a permission string: an action wrapping a role, e.g. `read("any")`, `update("user:abc")`, `delete("team:abc/owner")`. Actions are `read`, `create`, `update`, `delete` and the aggregate `write` (= create + update + delete); the role inside the quotes takes the form described under “Role strings” in this document's introduction.
    public let permissions: [String]
    /// Collection update date in ISO 8601 format.
    public let updatedAt: String
    /// Collection attributes.
    public let attributes: [AnyCodable]
    /// Maximum document size in bytes. Returns 0 when no limit applies.
    public let bytesMax: Int
    /// Currently used document size in bytes based on defined attributes.
    public let bytesUsed: Int
    /// Database ID.
    public let databaseId: String
    /// Whether document-level permissions are enabled. When it is, each record's own `$permissions` are enforced on top of the container's.
    public let documentSecurity: Bool
    /// Collection enabled. Can be 'enabled' or 'disabled'. When disabled, the collection is inaccessible to users, but remains accessible to Server SDKs using API keys.
    public let enabled: Bool
    /// Collection indexes.
    public let indexes: [Index]
    /// Collection name.
    public let name: String

    init(
        createdAt: String,
        id: String,
        permissions: [String],
        updatedAt: String,
        attributes: [AnyCodable],
        bytesMax: Int,
        bytesUsed: Int,
        databaseId: String,
        documentSecurity: Bool,
        enabled: Bool,
        indexes: [Index],
        name: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.permissions = permissions
        self.updatedAt = updatedAt
        self.attributes = attributes
        self.bytesMax = bytesMax
        self.bytesUsed = bytesUsed
        self.databaseId = databaseId
        self.documentSecurity = documentSecurity
        self.enabled = enabled
        self.indexes = indexes
        self.name = name
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.attributes = try container.decode([AnyCodable].self, forKey: .attributes)
        self.bytesMax = try container.decode(Int.self, forKey: .bytesMax)
        self.bytesUsed = try container.decode(Int.self, forKey: .bytesUsed)
        self.databaseId = try container.decode(String.self, forKey: .databaseId)
        self.documentSecurity = try container.decode(Bool.self, forKey: .documentSecurity)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.indexes = try container.decode([Index].self, forKey: .indexes)
        self.name = try container.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(attributes, forKey: .attributes)
        try container.encode(bytesMax, forKey: .bytesMax)
        try container.encode(bytesUsed, forKey: .bytesUsed)
        try container.encode(databaseId, forKey: .databaseId)
        try container.encode(documentSecurity, forKey: .documentSecurity)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(indexes, forKey: .indexes)
        try container.encode(name, forKey: .name)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$permissions": permissions as Any,
            "$updatedAt": updatedAt as Any,
            "attributes": attributes as Any,
            "bytesMax": bytesMax as Any,
            "bytesUsed": bytesUsed as Any,
            "databaseId": databaseId as Any,
            "documentSecurity": documentSecurity as Any,
            "enabled": enabled as Any,
            "indexes": indexes.map { $0.toMap() } as Any,
            "name": name as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Collection2 {
        return Collection2(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            permissions: map["$permissions"] as! [String],
            updatedAt: map["$updatedAt"] as! String,
            attributes: (map["attributes"] as! [Any]).map { AnyCodable($0) },
            bytesMax: map["bytesMax"] as! Int,
            bytesUsed: map["bytesUsed"] as! Int,
            databaseId: map["databaseId"] as! String,
            documentSecurity: map["documentSecurity"] as! Bool,
            enabled: map["enabled"] as! Bool,
            indexes: (map["indexes"] as! [[String: Any]]).map { Index.from(map: $0) },
            name: map["name"] as! String
        )
    }
}
