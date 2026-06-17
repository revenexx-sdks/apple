import Foundation
import JSONCodable

/// 
open class CartClaimRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case contact_id = "contact_id"
        case session_key = "session_key"
        case target_cart_id = "target_cart_id"
    }

    /// Contact taking ownership.
    public let contact_id: String
    /// Guest session whose active carts are handed over.
    public let session_key: String
    /// Merge the session carts into this cart instead of adopting them.
    public let target_cart_id: String?

    init(
        contact_id: String,
        session_key: String,
        target_cart_id: String?
    ) {
        self.contact_id = contact_id
        self.session_key = session_key
        self.target_cart_id = target_cart_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact_id = try container.decode(String.self, forKey: .contact_id)
        self.session_key = try container.decode(String.self, forKey: .session_key)
        self.target_cart_id = try container.decodeIfPresent(String.self, forKey: .target_cart_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(contact_id, forKey: .contact_id)
        try container.encode(session_key, forKey: .session_key)
        try container.encodeIfPresent(target_cart_id, forKey: .target_cart_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact_id": contact_id as Any,
            "session_key": session_key as Any,
            "target_cart_id": target_cart_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartClaimRequest {
        return CartClaimRequest(
            contact_id: map["contact_id"] as! String,
            session_key: map["session_key"] as! String,
            target_cart_id: map["target_cart_id"] as? String
        )
    }
}
