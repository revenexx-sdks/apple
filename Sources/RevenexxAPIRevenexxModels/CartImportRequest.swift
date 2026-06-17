import Foundation
import JSONCodable

/// Import into an existing cart (&#039;target_cart_id&#039;) or a new cart (owner &#039;contact_id&#039;/&#039;session_key&#039; required).
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

    /// Owner of a newly created cart.
    public let contact_id: String?
    /// Raw CSV content (alternative to payload for csv profiles).
    public let csv: String?
    /// Name for a newly created cart.
    public let name: String?
    /// The import payload: &#039;{cart, items}&#039; object, or a raw JSON/CSV string in the profile&#039;s format.
    public let payload: [String: AnyCodable]?
    /// Import profile to run; ad-hoc import when omitted.
    public let profile_id: String?
    /// Guest owner of a newly created cart.
    public let session_key: String?
    /// Existing active cart to import into.
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
