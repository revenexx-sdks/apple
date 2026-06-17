import Foundation
import JSONCodable

/// A cart needs an owner: &#039;contact_id&#039; (customer) or &#039;session_key&#039; (guest).
open class CartCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case contact_id = "contact_id"
        case currency = "currency"
        case is_current = "is_current"
        case market_id = "market_id"
        case metadata = "metadata"
        case name = "name"
        case session_key = "session_key"
    }

    /// 
    public let channel_id: String?
    /// Owning customer contact.
    public let contact_id: String?
    /// ISO 4217 code (default EUR).
    public let currency: String?
    /// Make this THE current cart of its owner.
    public let is_current: Bool?
    /// 
    public let market_id: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Display name (default &#039;Cart&#039;).
    public let name: String?
    /// Owning guest session.
    public let session_key: String?

    init(
        channel_id: String?,
        contact_id: String?,
        currency: String?,
        is_current: Bool?,
        market_id: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        session_key: String?
    ) {
        self.channel_id = channel_id
        self.contact_id = contact_id
        self.currency = currency
        self.is_current = is_current
        self.market_id = market_id
        self.metadata = metadata
        self.name = name
        self.session_key = session_key
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.is_current = try container.decodeIfPresent(Bool.self, forKey: .is_current)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.session_key = try container.decodeIfPresent(String.self, forKey: .session_key)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(is_current, forKey: .is_current)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(session_key, forKey: .session_key)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_id": channel_id as Any,
            "contact_id": contact_id as Any,
            "currency": currency as Any,
            "is_current": is_current as Any,
            "market_id": market_id as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "session_key": session_key as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartCreateRequest {
        return CartCreateRequest(
            channel_id: map["channel_id"] as? String,
            contact_id: map["contact_id"] as? String,
            currency: map["currency"] as? String,
            is_current: map["is_current"] as? Bool,
            market_id: map["market_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            session_key: map["session_key"] as? String
        )
    }
}
