import Foundation
import JSONCodable

/// Subscriber
open class Subscriber: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case providerType = "providerType"
        case target = "target"
        case targetId = "targetId"
        case topicId = "topicId"
        case userId = "userId"
        case userName = "userName"
    }

    /// Subscriber creation time in ISO 8601 format.
    public let createdAt: String
    /// Subscriber ID.
    public let id: String
    /// Subscriber update date in ISO 8601 format.
    public let updatedAt: String
    /// The target provider type. Can be one of the following: `email`, `sms` or `push`.
    public let providerType: String
    /// Target.
    public let target: Target
    /// Target ID.
    public let targetId: String
    /// Topic ID.
    public let topicId: String
    /// Topic ID.
    public let userId: String
    /// User Name.
    public let userName: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        providerType: String,
        target: Target,
        targetId: String,
        topicId: String,
        userId: String,
        userName: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.providerType = providerType
        self.target = target
        self.targetId = targetId
        self.topicId = topicId
        self.userId = userId
        self.userName = userName
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.providerType = try container.decode(String.self, forKey: .providerType)
        self.target = try container.decode(Target.self, forKey: .target)
        self.targetId = try container.decode(String.self, forKey: .targetId)
        self.topicId = try container.decode(String.self, forKey: .topicId)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.userName = try container.decode(String.self, forKey: .userName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(providerType, forKey: .providerType)
        try container.encode(target, forKey: .target)
        try container.encode(targetId, forKey: .targetId)
        try container.encode(topicId, forKey: .topicId)
        try container.encode(userId, forKey: .userId)
        try container.encode(userName, forKey: .userName)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "providerType": providerType as Any,
            "target": target.toMap() as Any,
            "targetId": targetId as Any,
            "topicId": topicId as Any,
            "userId": userId as Any,
            "userName": userName as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Subscriber {
        return Subscriber(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            providerType: map["providerType"] as! String,
            target: Target.from(map: map["target"] as! [String: Any]),
            targetId: map["targetId"] as! String,
            topicId: map["topicId"] as! String,
            userId: map["userId"] as! String,
            userName: map["userName"] as! String
        )
    }
}
