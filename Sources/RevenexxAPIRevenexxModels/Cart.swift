import Foundation
import JSONCodable

/// 
open class Cart: Codable {

    enum CodingKeys: String, CodingKey {
        case abandoned_at = "abandoned_at"
        case channel_id = "channel_id"
        case contact_id = "contact_id"
        case created_at = "created_at"
        case currency = "currency"
        case id = "id"
        case is_current = "is_current"
        case item_count = "item_count"
        case market_id = "market_id"
        case merged_into_cart_id = "merged_into_cart_id"
        case metadata = "metadata"
        case name = "name"
        case order_ref = "order_ref"
        case ordered_at = "ordered_at"
        case session_key = "session_key"
        case status = "status"
        case subtotal = "subtotal"
        case updated_at = "updated_at"
    }

    /// 
    public let abandoned_at: String?
    /// 
    public let channel_id: String?
    /// 
    public let contact_id: String?
    /// 
    public let created_at: String?
    /// 
    public let currency: String?
    /// 
    public let id: String?
    /// 
    public let is_current: Bool?
    /// 
    public let item_count: Int?
    /// 
    public let market_id: String?
    /// 
    public let merged_into_cart_id: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let order_ref: String?
    /// 
    public let ordered_at: String?
    /// 
    public let session_key: String?
    /// 
    public let status: String?
    /// 
    public let subtotal: Double?
    /// 
    public let updated_at: String?

    init(
        abandoned_at: String?,
        channel_id: String?,
        contact_id: String?,
        created_at: String?,
        currency: String?,
        id: String?,
        is_current: Bool?,
        item_count: Int?,
        market_id: String?,
        merged_into_cart_id: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        order_ref: String?,
        ordered_at: String?,
        session_key: String?,
        status: String?,
        subtotal: Double?,
        updated_at: String?
    ) {
        self.abandoned_at = abandoned_at
        self.channel_id = channel_id
        self.contact_id = contact_id
        self.created_at = created_at
        self.currency = currency
        self.id = id
        self.is_current = is_current
        self.item_count = item_count
        self.market_id = market_id
        self.merged_into_cart_id = merged_into_cart_id
        self.metadata = metadata
        self.name = name
        self.order_ref = order_ref
        self.ordered_at = ordered_at
        self.session_key = session_key
        self.status = status
        self.subtotal = subtotal
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.abandoned_at = try container.decodeIfPresent(String.self, forKey: .abandoned_at)
        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_current = try container.decodeIfPresent(Bool.self, forKey: .is_current)
        self.item_count = try container.decodeIfPresent(Int.self, forKey: .item_count)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.merged_into_cart_id = try container.decodeIfPresent(String.self, forKey: .merged_into_cart_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.ordered_at = try container.decodeIfPresent(String.self, forKey: .ordered_at)
        self.session_key = try container.decodeIfPresent(String.self, forKey: .session_key)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.subtotal = try container.decodeIfPresent(Double.self, forKey: .subtotal)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(abandoned_at, forKey: .abandoned_at)
        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_current, forKey: .is_current)
        try container.encodeIfPresent(item_count, forKey: .item_count)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(merged_into_cart_id, forKey: .merged_into_cart_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(ordered_at, forKey: .ordered_at)
        try container.encodeIfPresent(session_key, forKey: .session_key)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(subtotal, forKey: .subtotal)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "abandoned_at": abandoned_at as Any,
            "channel_id": channel_id as Any,
            "contact_id": contact_id as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "id": id as Any,
            "is_current": is_current as Any,
            "item_count": item_count as Any,
            "market_id": market_id as Any,
            "merged_into_cart_id": merged_into_cart_id as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "order_ref": order_ref as Any,
            "ordered_at": ordered_at as Any,
            "session_key": session_key as Any,
            "status": status as Any,
            "subtotal": subtotal as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Cart {
        return Cart(
            abandoned_at: map["abandoned_at"] as? String,
            channel_id: map["channel_id"] as? String,
            contact_id: map["contact_id"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            id: map["id"] as? String,
            is_current: map["is_current"] as? Bool,
            item_count: map["item_count"] as? Int,
            market_id: map["market_id"] as? String,
            merged_into_cart_id: map["merged_into_cart_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            order_ref: map["order_ref"] as? String,
            ordered_at: map["ordered_at"] as? String,
            session_key: map["session_key"] as? String,
            status: map["status"] as? String,
            subtotal: map["subtotal"] as? Double,
            updated_at: map["updated_at"] as? String
        )
    }
}
