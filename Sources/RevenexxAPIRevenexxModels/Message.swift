import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// Message
open class Message: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case data = "data"
        case deliveredAt = "deliveredAt"
        case deliveredTotal = "deliveredTotal"
        case deliveryErrors = "deliveryErrors"
        case providerType = "providerType"
        case scheduledAt = "scheduledAt"
        case status = "status"
        case targets = "targets"
        case topics = "topics"
        case users = "users"
    }

    /// Message creation time in ISO 8601 format.
    public let createdAt: String
    /// Message ID.
    public let id: String
    /// Message update date in ISO 8601 format.
    public let updatedAt: String
    /// Data of the message.
    public let data: [String: AnyCodable]
    /// The time when the message was delivered.
    public let deliveredAt: String?
    /// Number of recipients the message was delivered to.
    public let deliveredTotal: Int
    /// Delivery errors if any.
    public let deliveryErrors: [String]?
    /// Message provider type.
    public let providerType: String
    /// The scheduled time for message.
    public let scheduledAt: String?
    /// Status of delivery.
    public let status: Revenexx API — revenexxEnums.MessageStatus
    /// Target IDs set as recipients.
    public let targets: [String]
    /// Topic IDs set as recipients.
    public let topics: [String]
    /// User IDs set as recipients.
    public let users: [String]

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        data: [String: AnyCodable],
        deliveredAt: String?,
        deliveredTotal: Int,
        deliveryErrors: [String]?,
        providerType: String,
        scheduledAt: String?,
        status: Revenexx API — revenexxEnums.MessageStatus,
        targets: [String],
        topics: [String],
        users: [String]
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.data = data
        self.deliveredAt = deliveredAt
        self.deliveredTotal = deliveredTotal
        self.deliveryErrors = deliveryErrors
        self.providerType = providerType
        self.scheduledAt = scheduledAt
        self.status = status
        self.targets = targets
        self.topics = topics
        self.users = users
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.data = try container.decode([String: AnyCodable].self, forKey: .data)
        self.deliveredAt = try container.decodeIfPresent(String.self, forKey: .deliveredAt)
        self.deliveredTotal = try container.decode(Int.self, forKey: .deliveredTotal)
        self.deliveryErrors = try container.decodeIfPresent([String].self, forKey: .deliveryErrors)
        self.providerType = try container.decode(String.self, forKey: .providerType)
        self.scheduledAt = try container.decodeIfPresent(String.self, forKey: .scheduledAt)
        self.status = Revenexx API — revenexxEnums.MessageStatus(rawValue: try container.decode(String.self, forKey: .status))!
        self.targets = try container.decode([String].self, forKey: .targets)
        self.topics = try container.decode([String].self, forKey: .topics)
        self.users = try container.decode([String].self, forKey: .users)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(data, forKey: .data)
        try container.encodeIfPresent(deliveredAt, forKey: .deliveredAt)
        try container.encode(deliveredTotal, forKey: .deliveredTotal)
        try container.encodeIfPresent(deliveryErrors, forKey: .deliveryErrors)
        try container.encode(providerType, forKey: .providerType)
        try container.encodeIfPresent(scheduledAt, forKey: .scheduledAt)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(targets, forKey: .targets)
        try container.encode(topics, forKey: .topics)
        try container.encode(users, forKey: .users)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "data": data as Any,
            "deliveredAt": deliveredAt as Any,
            "deliveredTotal": deliveredTotal as Any,
            "deliveryErrors": deliveryErrors as Any,
            "providerType": providerType as Any,
            "scheduledAt": scheduledAt as Any,
            "status": status.rawValue as Any,
            "targets": targets as Any,
            "topics": topics as Any,
            "users": users as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Message {
        return Message(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            data: map["data"] as! [String: AnyCodable],
            deliveredAt: map["deliveredAt"] as? String,
            deliveredTotal: map["deliveredTotal"] as! Int,
            deliveryErrors: map["deliveryErrors"] as? [String],
            providerType: map["providerType"] as! String,
            scheduledAt: map["scheduledAt"] as? String,
            status: MessageStatus(rawValue: map["status"] as! String)!,
            targets: map["targets"] as! [String],
            topics: map["topics"] as! [String],
            users: map["users"] as! [String]
        )
    }
}
