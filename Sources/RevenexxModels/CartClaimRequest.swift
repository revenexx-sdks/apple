import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class CartClaimRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case contact_id = "contact_id"
        case session_key = "session_key"
        case strategy = "strategy"
        case target_cart_id = "target_cart_id"
    }

    /// The contact taking ownership. Every active cart of that session ends up with this contact — adopted as it stands, or folded into `target_cart_id`.
    public let contact_id: String
    /// The guest session whose active carts are handed over — the key the storefront keeps in its own session or cookie and has been sending on every anonymous call. This app neither issues nor parses it, so the example shows the shape of an opaque token and not a format anything enforces.
    public let session_key: String
    /// Override the tenant's cart_merge_strategy for this call: 'merge' keeps the target cart's own lines, 'replace' clears them first. Omit to use the setting.
    public let strategy: RevenexxEnums.CartMergeStrategy?
    /// Merge the session carts into this cart instead of adopting them.
    public let target_cart_id: String?

    init(
        contact_id: String,
        session_key: String,
        strategy: RevenexxEnums.CartMergeStrategy?,
        target_cart_id: String?
    ) {
        self.contact_id = contact_id
        self.session_key = session_key
        self.strategy = strategy
        self.target_cart_id = target_cart_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact_id = try container.decode(String.self, forKey: .contact_id)
        self.session_key = try container.decode(String.self, forKey: .session_key)
        if let strategyString = try container.decodeIfPresent(String.self, forKey: .strategy) {
            self.strategy = RevenexxEnums.CartMergeStrategy(rawValue: strategyString)
        } else {
            self.strategy = nil
        }
        self.target_cart_id = try container.decodeIfPresent(String.self, forKey: .target_cart_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(contact_id, forKey: .contact_id)
        try container.encode(session_key, forKey: .session_key)
        try container.encodeIfPresent(strategy?.rawValue, forKey: .strategy)
        try container.encodeIfPresent(target_cart_id, forKey: .target_cart_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact_id": contact_id as Any,
            "session_key": session_key as Any,
            "strategy": strategy?.rawValue as Any,
            "target_cart_id": target_cart_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartClaimRequest {
        return CartClaimRequest(
            contact_id: map["contact_id"] as! String,
            session_key: map["session_key"] as! String,
            strategy: map["strategy"] as? String != nil ? CartMergeStrategy(rawValue: map["strategy"] as! String) : nil,
            target_cart_id: map["target_cart_id"] as? String
        )
    }
}
