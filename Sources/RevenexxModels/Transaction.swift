import Foundation
import JSONCodable

/// Transaction
open class Transaction: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case expiresAt = "expiresAt"
        case operations = "operations"
        case status = "status"
    }

    /// Transaction creation time in ISO 8601 format.
    public let createdAt: String
    /// Transaction ID.
    public let id: String
    /// Transaction update date in ISO 8601 format.
    public let updatedAt: String
    /// Expiration time in ISO 8601 format.
    public let expiresAt: String
    /// Number of operations in the transaction.
    public let operations: Int
    /// Current status of the transaction. One of: pending, committing, committed, rolled_back, failed.
    public let status: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        expiresAt: String,
        operations: Int,
        status: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.expiresAt = expiresAt
        self.operations = operations
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.expiresAt = try container.decode(String.self, forKey: .expiresAt)
        self.operations = try container.decode(Int.self, forKey: .operations)
        self.status = try container.decode(String.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(expiresAt, forKey: .expiresAt)
        try container.encode(operations, forKey: .operations)
        try container.encode(status, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "expiresAt": expiresAt as Any,
            "operations": operations as Any,
            "status": status as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Transaction {
        return Transaction(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            expiresAt: map["expiresAt"] as! String,
            operations: map["operations"] as! Int,
            status: map["status"] as! String
        )
    }
}
