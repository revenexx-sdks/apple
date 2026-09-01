import Foundation
import JSONCodable

/// Target
open class Target: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case expired = "expired"
        case identifier = "identifier"
        case name = "name"
        case providerId = "providerId"
        case providerType = "providerType"
        case userId = "userId"
    }

    /// Target creation time in ISO 8601 format.
    public let createdAt: String
    /// Target ID.
    public let id: String
    /// Target update date in ISO 8601 format.
    public let updatedAt: String
    /// Is the target expired.
    public let expired: Bool
    /// The target identifier.
    public let identifier: String
    /// Target Name.
    public let name: String
    /// Provider ID.
    public let providerId: String?
    /// The target provider type. Can be one of the following: `email`, `sms` or `push`.
    public let providerType: String
    /// User ID.
    public let userId: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        expired: Bool,
        identifier: String,
        name: String,
        providerId: String?,
        providerType: String,
        userId: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.expired = expired
        self.identifier = identifier
        self.name = name
        self.providerId = providerId
        self.providerType = providerType
        self.userId = userId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.expired = try container.decode(Bool.self, forKey: .expired)
        self.identifier = try container.decode(String.self, forKey: .identifier)
        self.name = try container.decode(String.self, forKey: .name)
        self.providerId = try container.decodeIfPresent(String.self, forKey: .providerId)
        self.providerType = try container.decode(String.self, forKey: .providerType)
        self.userId = try container.decode(String.self, forKey: .userId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(expired, forKey: .expired)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(providerId, forKey: .providerId)
        try container.encode(providerType, forKey: .providerType)
        try container.encode(userId, forKey: .userId)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "expired": expired as Any,
            "identifier": identifier as Any,
            "name": name as Any,
            "providerId": providerId as Any,
            "providerType": providerType as Any,
            "userId": userId as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Target {
        return Target(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            expired: map["expired"] as! Bool,
            identifier: map["identifier"] as! String,
            name: map["name"] as! String,
            providerId: map["providerId"] as? String,
            providerType: map["providerType"] as! String,
            userId: map["userId"] as! String
        )
    }
}
