import Foundation
import JSONCodable

/// Document
open class Document<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case collectionId = "$collectionId"
        case createdAt = "$createdAt"
        case databaseId = "$databaseId"
        case id = "$id"
        case permissions = "$permissions"
        case sequence = "$sequence"
        case updatedAt = "$updatedAt"
        case data
    }

    /// Collection ID.
    public let collectionId: String
    /// Document creation date in ISO 8601 format.
    public let createdAt: String
    /// Database ID.
    public let databaseId: String
    /// Document ID.
    public let id: String
    /// Document permissions. Each entry is a permission string: an action wrapping a role, e.g. `read("any")`, `update("user:abc")`, `delete("team:abc/owner")`. Actions are `read`, `create`, `update`, `delete` and the aggregate `write` (= create + update + delete); the role inside the quotes takes the form described under “Role strings” in this document's introduction.
    public let permissions: [String]
    /// Document automatically incrementing ID.
    public let sequence: Int
    /// Document update date in ISO 8601 format.
    public let updatedAt: String
    /// Additional properties
    public let data: T

    init(
        collectionId: String,
        createdAt: String,
        databaseId: String,
        id: String,
        permissions: [String],
        sequence: Int,
        updatedAt: String,
        data: T
    ) {
        self.collectionId = collectionId
        self.createdAt = createdAt
        self.databaseId = databaseId
        self.id = id
        self.permissions = permissions
        self.sequence = sequence
        self.updatedAt = updatedAt
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.collectionId = try container.decode(String.self, forKey: .collectionId)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.databaseId = try container.decode(String.self, forKey: .databaseId)
        self.id = try container.decode(String.self, forKey: .id)
        self.permissions = try container.decode([String].self, forKey: .permissions)
        self.sequence = try container.decode(Int.self, forKey: .sequence)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(collectionId, forKey: .collectionId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(databaseId, forKey: .databaseId)
        try container.encode(id, forKey: .id)
        try container.encode(permissions, forKey: .permissions)
        try container.encode(sequence, forKey: .sequence)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "$collectionId": collectionId as Any,
            "$createdAt": createdAt as Any,
            "$databaseId": databaseId as Any,
            "$id": id as Any,
            "$permissions": permissions as Any,
            "$sequence": sequence as Any,
            "$updatedAt": updatedAt as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> Document {
        return Document(
            collectionId: map["$collectionId"] as? String ?? "",
            createdAt: map["$createdAt"] as? String ?? "",
            databaseId: map["$databaseId"] as? String ?? "",
            id: map["$id"] as? String ?? "",
            permissions: map["$permissions"] as? [String] ?? [],
            sequence: map["$sequence"] as? Int ?? 0,
            updatedAt: map["$updatedAt"] as? String ?? "",
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
