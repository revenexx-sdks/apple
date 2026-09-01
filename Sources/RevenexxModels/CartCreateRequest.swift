import Foundation
import JSONCodable

/// A cart needs an owner: 'contact_id' (customer) or 'session_key' (guest).
open class CartCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case contact_id = "contact_id"
        case currency = "currency"
        case is_current = "is_current"
        case metadata = "metadata"
        case name = "name"
        case session_key = "session_key"
    }

    /// The sales channel this cart is being opened in, as a channel of the channels app. Stored for attribution; nothing in this app reads it.
    public let channel_id: String?
    /// The customer who owns this cart, as a contact of the customers app. Send this OR session_key — a cart with neither owner is refused.
    public let contact_id: String?
    /// ISO 4217 code the cart is priced in (default EUR). Lines added without a currency inherit it.
    public let currency: String?
    /// Make this THE current cart of its owner as it is created — the same thing carts.activate does later, and it clears the flag on every sibling cart of the same owner.
    public let is_current: Bool?
    /// Free-form data the storefront hangs on the cart. Stored and returned verbatim; no key in here is read by this app, and none is indexed.
    public let metadata: [String: AnyCodable]?
    /// What the buyer calls this cart (default 'Cart'). An empty string is legal and lands on the default.
    public let name: String?
    /// The guest session that owns this cart — the key the storefront already keeps in its own session or cookie. Any non-empty string is accepted; this app issues none and parses none, so the example shows a shape and not a format. Send this OR contact_id.
    public let session_key: String?

    init(
        channel_id: String?,
        contact_id: String?,
        currency: String?,
        is_current: Bool?,
        metadata: [String: AnyCodable]?,
        name: String?,
        session_key: String?
    ) {
        self.channel_id = channel_id
        self.contact_id = contact_id
        self.currency = currency
        self.is_current = is_current
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
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            session_key: map["session_key"] as? String
        )
    }
}
