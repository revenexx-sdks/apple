import Foundation
import JSONCodable

/// ResourceToken
open class ResourceToken: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case accessedAt = "accessedAt"
        case expire = "expire"
        case resourceId = "resourceId"
        case resourceType = "resourceType"
        case secret = "secret"
    }

    /// Token creation date in ISO 8601 format.
    public let createdAt: String
    /// Token ID.
    public let id: String
    /// Most recent access date in ISO 8601 format. This attribute is only updated again after 24 hours.
    public let accessedAt: String
    /// Token expiration date in ISO 8601 format.
    public let expire: String
    /// Resource ID.
    public let resourceId: String
    /// Resource type.
    public let resourceType: String
    /// JWT encoded string.
    public let secret: String

    init(
        createdAt: String,
        id: String,
        accessedAt: String,
        expire: String,
        resourceId: String,
        resourceType: String,
        secret: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.accessedAt = accessedAt
        self.expire = expire
        self.resourceId = resourceId
        self.resourceType = resourceType
        self.secret = secret
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.accessedAt = try container.decode(String.self, forKey: .accessedAt)
        self.expire = try container.decode(String.self, forKey: .expire)
        self.resourceId = try container.decode(String.self, forKey: .resourceId)
        self.resourceType = try container.decode(String.self, forKey: .resourceType)
        self.secret = try container.decode(String.self, forKey: .secret)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(accessedAt, forKey: .accessedAt)
        try container.encode(expire, forKey: .expire)
        try container.encode(resourceId, forKey: .resourceId)
        try container.encode(resourceType, forKey: .resourceType)
        try container.encode(secret, forKey: .secret)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "accessedAt": accessedAt as Any,
            "expire": expire as Any,
            "resourceId": resourceId as Any,
            "resourceType": resourceType as Any,
            "secret": secret as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ResourceToken {
        return ResourceToken(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            accessedAt: map["accessedAt"] as! String,
            expire: map["expire"] as! String,
            resourceId: map["resourceId"] as! String,
            resourceType: map["resourceType"] as! String,
            secret: map["secret"] as! String
        )
    }
}
