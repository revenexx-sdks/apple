import Foundation
import JSONCodable

/// Import into an existing cart ('target_cart_id') or a new cart (owner 'contact_id'/'session_key' required).
open class CartImportRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case contact_id = "contact_id"
        case csv = "csv"
        case name = "name"
        case payload = "payload"
        case profile_id = "profile_id"
        case session_key = "session_key"
        case target_cart_id = "target_cart_id"
    }

    /// Owner of the cart this import creates. Ignored when target_cart_id is sent.
    public let contact_id: String?
    /// The CSV rows, when that is easier than putting them in `payload`. First line is the header, and its names are the ones the profile's mapping expects (the bundled quick-order template reads sku, name, quantity, unit_price). Numbers are coerced; a JSON column survives as a JSON string.
    public let csv: String?
    /// Name for the cart this import creates. A name in the payload's own `cart` block wins over it; without either the cart is called 'Imported cart'.
    public let name: String?
    /// The import itself. As an object: `{ "cart": { name, status, currency, channel_id, metadata }, "items": [ … ] }` — the same document carts.export produces, so an export round-trips. As a string: that document as raw JSON, or CSV rows when the profile is a csv one. A line with neither `name` nor `sku` is dropped, and a payload that leaves no line at all is a 400.
    public let payload: [String: AnyCodable]?
    /// The import profile to run — one of the ids `GET /carts/io/profiles?direction=import` lists. Omit it for an ad-hoc import: the payload is then read in the canonical shape, and as CSV if `csv` is what carried it.
    public let profile_id: String?
    /// Guest owner of the cart this import creates — the storefront's own session key. Ignored when target_cart_id is sent.
    public let session_key: String?
    /// An existing ACTIVE cart to import into. The lines are added to it (merging identical product lines), unless the profile says `apply_mode: replace`, which clears it first. Without this a new cart is created and an owner is required.
    public let target_cart_id: String?

    init(
        contact_id: String?,
        csv: String?,
        name: String?,
        payload: [String: AnyCodable]?,
        profile_id: String?,
        session_key: String?,
        target_cart_id: String?
    ) {
        self.contact_id = contact_id
        self.csv = csv
        self.name = name
        self.payload = payload
        self.profile_id = profile_id
        self.session_key = session_key
        self.target_cart_id = target_cart_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.csv = try container.decodeIfPresent(String.self, forKey: .csv)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.payload = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payload)
        self.profile_id = try container.decodeIfPresent(String.self, forKey: .profile_id)
        self.session_key = try container.decodeIfPresent(String.self, forKey: .session_key)
        self.target_cart_id = try container.decodeIfPresent(String.self, forKey: .target_cart_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(csv, forKey: .csv)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(payload, forKey: .payload)
        try container.encodeIfPresent(profile_id, forKey: .profile_id)
        try container.encodeIfPresent(session_key, forKey: .session_key)
        try container.encodeIfPresent(target_cart_id, forKey: .target_cart_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact_id": contact_id as Any,
            "csv": csv as Any,
            "name": name as Any,
            "payload": payload as Any,
            "profile_id": profile_id as Any,
            "session_key": session_key as Any,
            "target_cart_id": target_cart_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartImportRequest {
        return CartImportRequest(
            contact_id: map["contact_id"] as? String,
            csv: map["csv"] as? String,
            name: map["name"] as? String,
            payload: map["payload"] as? [String: AnyCodable],
            profile_id: map["profile_id"] as? String,
            session_key: map["session_key"] as? String,
            target_cart_id: map["target_cart_id"] as? String
        )
    }
}
