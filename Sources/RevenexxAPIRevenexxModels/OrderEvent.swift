import Foundation
import JSONCodable

/// 
open class OrderEvent: Codable {

    enum CodingKeys: String, CodingKey {
        case actor = "actor"
        case created_at = "created_at"
        case id = "id"
        case name = "name"
        case order_id = "order_id"
        case payload = "payload"
    }

    /// 
    public let actor: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let name: String?
    /// 
    public let order_id: String?
    /// 
    public let payload: [String: AnyCodable]?

    init(
        actor: String?,
        created_at: String?,
        id: String?,
        name: String?,
        order_id: String?,
        payload: [String: AnyCodable]?
    ) {
        self.actor = actor
        self.created_at = created_at
        self.id = id
        self.name = name
        self.order_id = order_id
        self.payload = payload
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.actor = try container.decodeIfPresent(String.self, forKey: .actor)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.payload = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payload)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(actor, forKey: .actor)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(payload, forKey: .payload)
    }

    public func toMap() -> [String: Any] {
        return [
            "actor": actor as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "name": name as Any,
            "order_id": order_id as Any,
            "payload": payload as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderEvent {
        return OrderEvent(
            actor: map["actor"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            name: map["name"] as? String,
            order_id: map["order_id"] as? String,
            payload: map["payload"] as? [String: AnyCodable]
        )
    }
}
