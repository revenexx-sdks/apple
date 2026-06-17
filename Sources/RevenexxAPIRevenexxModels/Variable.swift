import Foundation
import JSONCodable

/// Variable
open class Variable: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case key = "key"
        case resourceId = "resourceId"
        case resourceType = "resourceType"
        case secret = "secret"
        case value = "value"
    }

    /// Variable creation date in ISO 8601 format.
    public let createdAt: String
    /// Variable ID.
    public let id: String
    /// Variable creation date in ISO 8601 format.
    public let updatedAt: String
    /// Variable key.
    public let key: String
    /// ID of resource to which the variable belongs. If resourceType is &quot;project&quot;, it is empty. If resourceType is &quot;function&quot;, it is ID of the function.
    public let resourceId: String
    /// Service to which the variable belongs. Possible values are &quot;project&quot;, &quot;function&quot;
    public let resourceType: String
    /// Variable secret flag. Secret variables can only be updated or deleted, but never read.
    public let secret: Bool
    /// Variable value.
    public let value: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        key: String,
        resourceId: String,
        resourceType: String,
        secret: Bool,
        value: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.key = key
        self.resourceId = resourceId
        self.resourceType = resourceType
        self.secret = secret
        self.value = value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.key = try container.decode(String.self, forKey: .key)
        self.resourceId = try container.decode(String.self, forKey: .resourceId)
        self.resourceType = try container.decode(String.self, forKey: .resourceType)
        self.secret = try container.decode(Bool.self, forKey: .secret)
        self.value = try container.decode(String.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(key, forKey: .key)
        try container.encode(resourceId, forKey: .resourceId)
        try container.encode(resourceType, forKey: .resourceType)
        try container.encode(secret, forKey: .secret)
        try container.encode(value, forKey: .value)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "key": key as Any,
            "resourceId": resourceId as Any,
            "resourceType": resourceType as Any,
            "secret": secret as Any,
            "value": value as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Variable {
        return Variable(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            key: map["key"] as! String,
            resourceId: map["resourceId"] as! String,
            resourceType: map["resourceType"] as! String,
            secret: map["secret"] as! Bool,
            value: map["value"] as! String
        )
    }
}
