import Foundation
import JSONCodable

/// Topic
open class Topic: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case emailTotal = "emailTotal"
        case name = "name"
        case pushTotal = "pushTotal"
        case smsTotal = "smsTotal"
        case subscribe = "subscribe"
    }

    /// Topic creation time in ISO 8601 format.
    public let createdAt: String
    /// Topic ID.
    public let id: String
    /// Topic update date in ISO 8601 format.
    public let updatedAt: String
    /// Total count of email subscribers subscribed to the topic.
    public let emailTotal: Int
    /// The name of the topic.
    public let name: String
    /// Total count of push subscribers subscribed to the topic.
    public let pushTotal: Int
    /// Total count of SMS subscribers subscribed to the topic.
    public let smsTotal: Int
    /// Subscribe permissions.
    public let subscribe: [String]

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        emailTotal: Int,
        name: String,
        pushTotal: Int,
        smsTotal: Int,
        subscribe: [String]
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.emailTotal = emailTotal
        self.name = name
        self.pushTotal = pushTotal
        self.smsTotal = smsTotal
        self.subscribe = subscribe
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.emailTotal = try container.decode(Int.self, forKey: .emailTotal)
        self.name = try container.decode(String.self, forKey: .name)
        self.pushTotal = try container.decode(Int.self, forKey: .pushTotal)
        self.smsTotal = try container.decode(Int.self, forKey: .smsTotal)
        self.subscribe = try container.decode([String].self, forKey: .subscribe)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(emailTotal, forKey: .emailTotal)
        try container.encode(name, forKey: .name)
        try container.encode(pushTotal, forKey: .pushTotal)
        try container.encode(smsTotal, forKey: .smsTotal)
        try container.encode(subscribe, forKey: .subscribe)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "emailTotal": emailTotal as Any,
            "name": name as Any,
            "pushTotal": pushTotal as Any,
            "smsTotal": smsTotal as Any,
            "subscribe": subscribe as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Topic {
        return Topic(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            emailTotal: map["emailTotal"] as! Int,
            name: map["name"] as! String,
            pushTotal: map["pushTotal"] as! Int,
            smsTotal: map["smsTotal"] as! Int,
            subscribe: map["subscribe"] as! [String]
        )
    }
}
