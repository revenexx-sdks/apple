import Foundation
import JSONCodable

/// 
open class PushSubscription: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case endpoint = "endpoint"
        case id = "id"
        case last_seen_at = "last_seen_at"
        case subscriber_id = "subscriber_id"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
        case user_agent = "user_agent"
    }

    /// 
    public let created_at: String
    /// 
    public let endpoint: String
    /// 
    public let id: String
    /// 
    public let last_seen_at: String
    /// 
    public let subscriber_id: String
    /// 
    public let tenant_id: String
    /// 
    public let updated_at: String
    /// 
    public let user_agent: String

    init(
        created_at: String,
        endpoint: String,
        id: String,
        last_seen_at: String,
        subscriber_id: String,
        tenant_id: String,
        updated_at: String,
        user_agent: String
    ) {
        self.created_at = created_at
        self.endpoint = endpoint
        self.id = id
        self.last_seen_at = last_seen_at
        self.subscriber_id = subscriber_id
        self.tenant_id = tenant_id
        self.updated_at = updated_at
        self.user_agent = user_agent
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.endpoint = try container.decode(String.self, forKey: .endpoint)
        self.id = try container.decode(String.self, forKey: .id)
        self.last_seen_at = try container.decode(String.self, forKey: .last_seen_at)
        self.subscriber_id = try container.decode(String.self, forKey: .subscriber_id)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.user_agent = try container.decode(String.self, forKey: .user_agent)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(created_at, forKey: .created_at)
        try container.encode(endpoint, forKey: .endpoint)
        try container.encode(id, forKey: .id)
        try container.encode(last_seen_at, forKey: .last_seen_at)
        try container.encode(subscriber_id, forKey: .subscriber_id)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(updated_at, forKey: .updated_at)
        try container.encode(user_agent, forKey: .user_agent)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "endpoint": endpoint as Any,
            "id": id as Any,
            "last_seen_at": last_seen_at as Any,
            "subscriber_id": subscriber_id as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any,
            "user_agent": user_agent as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PushSubscription {
        return PushSubscription(
            created_at: map["created_at"] as! String,
            endpoint: map["endpoint"] as! String,
            id: map["id"] as! String,
            last_seen_at: map["last_seen_at"] as! String,
            subscriber_id: map["subscriber_id"] as! String,
            tenant_id: map["tenant_id"] as! String,
            updated_at: map["updated_at"] as! String,
            user_agent: map["user_agent"] as! String
        )
    }
}
