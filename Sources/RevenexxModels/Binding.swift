import Foundation
import JSONCodable

/// 
open class Binding: Codable {

    enum CodingKeys: String, CodingKey {
        case channel = "channel"
        case created_at = "created_at"
        case enabled = "enabled"
        case event_topic = "event_topic"
        case fallback_order = "fallback_order"
        case id = "id"
        case locale = "locale"
        case recipient = "recipient"
        case template_key = "template_key"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// 
    public let channel: String
    /// 
    public let created_at: String
    /// 
    public let enabled: Bool
    /// 
    public let event_topic: String
    /// 
    public let fallback_order: Int
    /// 
    public let id: String
    /// 
    public let locale: String
    /// 
    public let recipient: String
    /// 
    public let template_key: String
    /// 
    public let tenant_id: String
    /// 
    public let updated_at: String

    init(
        channel: String,
        created_at: String,
        enabled: Bool,
        event_topic: String,
        fallback_order: Int,
        id: String,
        locale: String,
        recipient: String,
        template_key: String,
        tenant_id: String,
        updated_at: String
    ) {
        self.channel = channel
        self.created_at = created_at
        self.enabled = enabled
        self.event_topic = event_topic
        self.fallback_order = fallback_order
        self.id = id
        self.locale = locale
        self.recipient = recipient
        self.template_key = template_key
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel = try container.decode(String.self, forKey: .channel)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.event_topic = try container.decode(String.self, forKey: .event_topic)
        self.fallback_order = try container.decode(Int.self, forKey: .fallback_order)
        self.id = try container.decode(String.self, forKey: .id)
        self.locale = try container.decode(String.self, forKey: .locale)
        self.recipient = try container.decode(String.self, forKey: .recipient)
        self.template_key = try container.decode(String.self, forKey: .template_key)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(channel, forKey: .channel)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(event_topic, forKey: .event_topic)
        try container.encode(fallback_order, forKey: .fallback_order)
        try container.encode(id, forKey: .id)
        try container.encode(locale, forKey: .locale)
        try container.encode(recipient, forKey: .recipient)
        try container.encode(template_key, forKey: .template_key)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel": channel as Any,
            "created_at": created_at as Any,
            "enabled": enabled as Any,
            "event_topic": event_topic as Any,
            "fallback_order": fallback_order as Any,
            "id": id as Any,
            "locale": locale as Any,
            "recipient": recipient as Any,
            "template_key": template_key as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Binding {
        return Binding(
            channel: map["channel"] as! String,
            created_at: map["created_at"] as! String,
            enabled: map["enabled"] as! Bool,
            event_topic: map["event_topic"] as! String,
            fallback_order: map["fallback_order"] as! Int,
            id: map["id"] as! String,
            locale: map["locale"] as! String,
            recipient: map["recipient"] as! String,
            template_key: map["template_key"] as! String,
            tenant_id: map["tenant_id"] as! String,
            updated_at: map["updated_at"] as! String
        )
    }
}
