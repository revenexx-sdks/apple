import Foundation
import JSONCodable
import RevenexxEnums

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
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// When the cart was abandoned — by hand, or by the cart-maintenance sweep. This is the only instant the abandonment funnel has, and nothing else in the platform writes it. carts.reopen clears it.
    public let abandoned_at: String?
    /// The sales channel the cart was opened in (web shop, app, agent desk), as a channel of the channels app. Carried to the order for attribution; nothing in this app reads it.
    public let channel_id: String?
    /// The customer who owns this cart, as a contact of the customers app. Null on a guest cart: the database requires one of contact_id and session_key, never neither.
    public let contact_id: String?
    /// When the cart was opened.
    public let created_at: String?
    /// ISO 4217 code the whole cart is priced in. A line added without a currency of its own inherits this one.
    public let currency: String?
    /// The cart, as every other route addresses it. Stable for the cart's whole life: a merge closes a cart, it never renumbers one.
    public let id: String?
    /// THE current cart of this owner — the flag carts.activate writes, and reading it back is what `?is_current=true` is for. At most one cart per owner carries it: activating one clears it on every sibling, and abandoning, ordering or merging a cart clears it. A storefront resuming a session asks for it together with contact_id or session_key.
    public let is_current: Bool?
    /// Total QUANTITY in the cart, not the number of lines: the sum of every line's quantity, rounded. Two lines of five pieces each answer 10, not 2. Recomputed by this app after every line write — a value a client sends is ignored.
    public let item_count: Int?
    /// The market this cart is scoped to, stamped by the platform. It decides which market's settings apply — including the retention windows the sweep deletes on. Null on a cart that belongs to no market, which runs on the tenant baseline. Cart lines and io profiles carry no market of their own; a line's market is its cart's.
    public let market_id: String?
    /// The cart this one was merged into, written together with status 'merged'. The lines are in the target now and this is the trail back — the answer to 'where did my cart go'. Null on every cart that was never merged.
    public let merged_into_cart_id: String?
    /// Free-form data the storefront hangs on the cart. Stored and returned verbatim; no key in here is read by this app, and none is indexed.
    public let metadata: [String: AnyCodable]?
    /// What the buyer calls this cart. B2B customers keep several named carts side by side — 'Weekly order', 'Site B', 'Q3 budget' — which is what multi_cart_enabled turns on; a storefront with one cart per buyer leaves it at the default 'Cart'.
    public let name: String?
    /// The order this cart became, in whatever numbering order management uses. Free text: this app stores what it is handed and never resolves it. Filtering on it is how a support agent gets from an order number back to the cart behind it.
    public let order_ref: String?
    /// When the cart was handed to order management. Written once, with the status, and never cleared.
    public let ordered_at: String?
    /// How a cart is identified BEFORE anyone logs in — the opaque key the storefront already keeps in its own session or cookie and sends back on every anonymous call. This app neither issues nor parses it; any non-empty string is a valid key, so its format is the storefront's own. On login carts.claim hands every active cart of one session_key to a contact, and this becomes null.
    public let session_key: String?
    /// Where the cart stands in its lifecycle. 'active' is the only status that accepts a write of any kind. 'abandoned' is set by hand or by the cart-maintenance sweep and is the one reversible ending (carts.reopen). 'ordered' and 'merged' are final — the cart is a record now, not a workspace.
    public let status: RevenexxEnums.CartStatus?
    /// Sum of every line's line_total, in the cart's currency, net — before shipping, before tax. Recomputed after every line write, and written once more by carts.order when price_snapshot_mode settles which of a line's two prices is charged.
    public let subtotal: Double?
    /// The tenant this row belongs to, echoed by the data plane. Always the tenant the request was made for — it is not a way to reach another one.
    public let tenant_id: String?
    /// The last time anything about this cart or its lines changed — every write path in this app stamps it. It is also what the maintenance sweep measures idleness with, which is why the abandonment sweep is the one write that deliberately does not touch it: noticing that a cart is idle must not reset the clock that decides how long it is kept.
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
        status: RevenexxEnums.CartStatus?,
        subtotal: Double?,
        tenant_id: String?,
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
        self.tenant_id = tenant_id
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
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.CartStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.subtotal = try container.decodeIfPresent(Double.self, forKey: .subtotal)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
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
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(subtotal, forKey: .subtotal)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
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
            "status": status?.rawValue as Any,
            "subtotal": subtotal as Any,
            "tenant_id": tenant_id as Any,
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
            status: map["status"] as? String != nil ? CartStatus(rawValue: map["status"] as! String) : nil,
            subtotal: map["subtotal"] as? Double,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
